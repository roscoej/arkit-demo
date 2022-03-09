//
//  Helpers.swift
//  SwiftUI ARKit Test
//
//  Created by Elliott Io on 5/21/21.
//

import Foundation

import SwiftUI

//MARK: Color Extension Functions
/// Color extension for custom colors defined in the Colors.xcassets
extension Color {
    static let appBackground = Color("appBackground")
    static let appLabel = Color("appLabel")
    static let appBackgroundSecondary = Color("appBackgroundSecondary")
    static let appBackgroundTertiary = Color("appBackgroundTertiary")
}

//MARK: String Extension Functions
extension String {
    /// Gets value from Localizable.strings
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
