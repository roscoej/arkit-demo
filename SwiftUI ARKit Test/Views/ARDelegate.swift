//
//  ARDelegate.swift
//  SwiftUI ARKit Test
//
//  Created by Jacob Roscoe on 3/9/22.
//

import ARKit
import FocusEntity
import Foundation
import RealityKit

enum ARViewStatus {
    case tracking
    case ready
    case capturing
}

class ARDelegate: NSObject, ObservableObject {

    @Published var status: ARViewStatus = .tracking

    private var arView: RealityKit.ARView?
    var focusEntity: FocusEntity?
    var diceEntity: ModelEntity?

    func newARView() -> RealityKit.ARView {
        let arView = RealityKit.ARView()
        focusEntity = nil
        diceEntity = nil
        status = .tracking

        let session = arView.session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        session.run(config)

        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.session = session
        coachingOverlay.goal = .horizontalPlane
        arView.addSubview(coachingOverlay)

        session.delegate = self

        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

        self.arView = arView
        return arView
    }

    @objc func handleTap() {
        guard let arView = self.arView, let focusEntity = self.focusEntity else { return }

        if let diceEntity = self.diceEntity {
            // roll the dice on 2nd tap
            diceEntity.addForce([0, 2, 0], relativeTo: nil)
            diceEntity.addTorque([Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4), Float.random(in: 0 ... 0.4)], relativeTo: nil)
        } else {
            // create the dice on 1st tap
            let anchor = AnchorEntity()
            arView.scene.addAnchor(anchor)

            let diceEntity = try! Entity.loadModel(named: "Dice")
            diceEntity.scale = [0.1, 0.1, 0.1]
            diceEntity.position = focusEntity.position

            let extent = diceEntity.visualBounds(relativeTo: diceEntity).extents.y
            let boxShape = ShapeResource.generateBox(size: [extent, extent, extent])
            diceEntity.collision = CollisionComponent(shapes: [boxShape])
            
            var diceMaterial = PhysicallyBasedMaterial()
            diceMaterial.baseColor = PhysicallyBasedMaterial.BaseColor(tint:.orange)
            diceMaterial.roughness = PhysicallyBasedMaterial.Roughness(floatLiteral: 0.0)
            diceMaterial.metallic = PhysicallyBasedMaterial.Metallic(floatLiteral: 0.8)

            diceEntity.physicsBody = PhysicsBodyComponent(
                massProperties: .init(shape: boxShape, mass: 50),
                material: nil,
                mode: .dynamic
            )

            diceEntity.model?.materials = [diceMaterial]

            self.diceEntity = diceEntity
            anchor.addChild(diceEntity)

            // Create a plane below the dice
            let planeMesh = MeshResource.generatePlane(width: 2, depth: 2)
            let planeMaterial = SimpleMaterial(color: .init(white: 1.0, alpha: 0.1), isMetallic: false)
            let planeEntity = ModelEntity(mesh: planeMesh, materials: [planeMaterial])
            planeEntity.position = focusEntity.position
            planeEntity.physicsBody = PhysicsBodyComponent(massProperties: .default, material: nil, mode: .static)
            planeEntity.collision = CollisionComponent(shapes: [.generateBox(width: 2, height: 0.001, depth: 2)])
            planeEntity.position = focusEntity.position
            anchor.addChild(planeEntity)

            status = .ready
        }
    }

    func captureSnapshot() {
        guard let arView = self.arView, status == .ready else { return }
        status = .capturing
        arView.snapshot(saveToHDR: true) { [weak self] image in
            guard let image = image else { return }
            StoreManager.storeImage(image)
            self?.status = .ready
        }
    }
}

extension ARDelegate: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let arView = self.arView else { return }
        self.focusEntity = FocusEntity(on: arView, style: .classic(color: .yellow))
    }
}
