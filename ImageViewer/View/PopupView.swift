//
//  PopupView.swift
//  ImageViewer
//
//  Created by Gautham C on 6/26/24.
//

import SwiftUI

struct PopupView: View {
    
    @Binding var imageData : ImageData?
    @Binding var showingPopup : Bool
    
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                    showingPopup = false
                }, label: {
                    Text("Dismiss")
                })
                Spacer()
                AsyncImage(url: URL(string: imageData?.largeImageURL ?? "")){ phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .padding(.horizontal)
                    case .failure(_):
                        Image(systemName: "xmark.circle")
                    @unknown default:
                        EmptyView()
                    }
                }
                HStack{
                    Text(Constants.likes)
                    Spacer()
                    Text(String(imageData?.likes ?? 0))
                }
                HStack{
                    Text(Constants.createdBy)
                    Spacer()
                    Text(imageData?.user ?? Constants.noUser)
                }
                HStack{
                    Text(Constants.tags)
                    Spacer()
                    Text(imageData?.tags ?? Constants.noTags)
                }
            }
        }
        .padding()
        .aspectRatio(contentMode: .fit)
    }
}



