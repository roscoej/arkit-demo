//
//  ContentView.swift
//  SwiftUI ARKit Test
//
//  Created by Elliott on 5/14/21.
//

import CoreData
import SwiftUI

struct ContentView: View {
    
    // MARK: - View Model
    
    // MARK: - Environments
    
    // MARK: - EnvironmentObjects
    
    // MARK: - StateObjects
    
    // MARK: - ObservedObjects
    
    // MARK: - States
    
    // MARK: - Bindings
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ARView()) {
                    CardView(title: "Begin VR")
                }
                NavigationLink(destination: HistoryView()) {
                    CardView(title: "VR History")
                }
            }
            .frame(minWidth: nil, idealWidth: nil, maxWidth: nil, minHeight: 100, idealHeight: nil, maxHeight: 250, alignment: .center)
            .navigationBarTitle("ARKit Demo")
        }
    }
}

// MARK: - Lifecycle
extension ContentView {
    func didAppear() {
    }
    
    func didDisappear() {
    }
}

// MARK: - Supplementary Views
extension ContentView {
    
}

// MARK: - Actions
extension ContentView {
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

