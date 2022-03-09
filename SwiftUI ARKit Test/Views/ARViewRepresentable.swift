//
//  ARViewRepresentable.swift
//  SwiftUI ARKit Test
//
//  Created by Jaocb Roscoe on 3/8/22.
//

import ARKit
import SwiftUI

struct ARViewRepresentable: UIViewRepresentable {

    let arDelegate: ARDelegate

    func makeUIView(context: Context) -> some UIView {
        return arDelegate.newARView()
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func makeCoordinator() -> ARDelegate {
        return arDelegate
    }
}

struct ARViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        ARViewRepresentable(arDelegate: ARDelegate())
    }
}
