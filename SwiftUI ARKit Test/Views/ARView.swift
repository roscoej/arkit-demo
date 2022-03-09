//
//  ARView.swift
//  SwiftUI ARKit Test
//
//  Created by Paxton Burch on 2/24/22.
//

import SwiftUI

struct ARView: View {

    @Environment(\.presentationMode) var presentation
    @ObservedObject var arDelegate = ARDelegate()
    
    var body: some View {
        ZStack {
            ARViewRepresentable(arDelegate: arDelegate)
            VStack {
                Spacer()
                Button(action: {
                    arDelegate.captureSnapshot()
                }, label: {
                    Image(systemName: "circle.inset.filled")
                        .resizable()
                        .frame(width: 64, height: 64)
                })
                    .tint(.white)
                    .padding(.bottom, 44)
                    .disabled(arDelegate.status != .ready)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Image(systemName: "arrow.left")
                                .foregroundColor(.blue)
                                .onTapGesture {
            self.presentation.wrappedValue.dismiss()
        })
    }
}

struct ARView_Previews: PreviewProvider {
    static var previews: some View {
        ARView()
    }
}
