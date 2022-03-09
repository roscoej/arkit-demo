//
//  CardView.swift
//  SwiftUI ARKit Test
//
//  Created by Elliott on 5/20/21.
//

import Foundation
import SwiftUI

struct CardView: View {
    
    // MARK: - View Model
    
    // MARK: - Environments
    
    // MARK: - EnvironmentObjects
    
    // MARK: - StateObjects
    
    // MARK: - ObservedObjects
    
    // MARK: - States
    
    // MARK: - Bindings
    
    // MARK: - Properties
    let title: String
    
    // MARK: - Body
    var body: some View {
        content()
            .onAppear { didAppear() }
            .onDisappear { didDisappear() }
    }
}

// MARK: - Content
extension CardView {
    func content() -> some View {
        ZStack {
            Color.appBackgroundTertiary.cornerRadius(10).shadow(radius: 5)
            VStack {
                Text(title)
                    .accessibility(identifier: "cardModel.title")
                    .foregroundColor(.appLabel)
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
        }
        .padding(15)
    }
}

// MARK: - Navigation Links
extension CardView {
    
}

// MARK: - Lifecycle
extension CardView {
    func didAppear() {
        
    }
    
    func didDisappear() {
        
    }
}

// MARK: - Supplementary Views
extension CardView {
    
}

// MARK: - Actions
extension CardView {

}
