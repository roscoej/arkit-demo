//
//  HistoryView.swift
//  SwiftUI ARKit Test
//
//  Created by Jacob Roscoe on 3/8/22.
//

import SwiftUI

struct HistoryView: View {

    @Environment(\.presentationMode) var presentation
    @GestureState var isDetectingLongPress = false
    @State var imageURL: URL?

    private var imgArray: [[URL]] { StoreManager.fetchImageURLs().chunked(into: 3) }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ForEach (imgArray, id: \.self) { array in
                    HStack {
                        // create 3 image placement on every row.
                        ForEach (0..<3, id: \.self) { index in
                            if index < array.count {
                                AsyncImage(url: array[index]) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: geometry.size.width * 0.3, height:  geometry.size.width * 0.3)
                                            .clipped()
                                    case .failure:
                                        EmptyView()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .clipped()
                                .cornerRadius(8)
                                .gesture(LongPressGesture(minimumDuration: 60)
                                            .updating($isDetectingLongPress) { currentstate, gestureState,
                                    transaction in

                                    gestureState = currentstate
                                    transaction.animation = Animation.spring()
                                }
                                            .onChanged({ _ in
                                    imageURL = array[index]
                                })
                                )
                            } else {
                                // when there is no image left, then create clear rectangles.
                                Rectangle().fill(Color.clear)
                                    .frame(width: geometry.size.width * 0.3, height:  geometry.size.width * 0.3)
                            }
                        }
                    }
                    .frame(width:geometry.size.width,alignment: .center)
                }
            }
            .padding(.top)
            .frame(height: geometry.size.height, alignment: .top)
            .blur(radius: isDetectingLongPress ? 5 : 0)
            .navigationBarTitle("VR History")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    Image(systemName: "arrow.left")
                                    .foregroundColor(.blue)
                                    .onTapGesture {
                self.presentation.wrappedValue.dismiss()
            })

            if isDetectingLongPress {
                ImagePreview(imageURL: $imageURL)
                    .frame(width: geometry.size.width * 0.95, height: geometry.size.height * 0.95)
                    .transition(.scale)
            }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
