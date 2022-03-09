//
//  StoreManager.swift
//  SwiftUI ARKit Test
//
//  Created by Jacob Roscoe on 3/9/22.
//

import Foundation
import UIKit

struct StoreManager {
    static func storeImage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1),
              let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL
        else {
            return
        }
        do {
            try data.write(to: directory.appendingPathComponent(UUID().uuidString + ".png")!)
        } catch {
            print(error.localizedDescription)
        }
    }

    static func fetchImageURLs() -> [URL] {
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { return [] }

        do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: directory.path)
            return fileNames.map({ directory.appendingPathComponent($0) })
        } catch {
            return []
        }
    }
}
