//
//  ContentView.swift
//  ImageViewer
//
//  Created by Gautham C on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var imageName: String = ""
    @State var showingPopup : Bool = false
    @State var selectedImage : ImageData!
    @ObservedObject var network : NetworkManager
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    TextField(Constants.searchFieldText, text: $imageName)
                        .onSubmit {
                            if(!imageName.isEmpty){
                                network.imageToBeSearched(imageName)
                                network.fetchData()
                            }
                        }
                    Spacer()
                    Button(action: {
                        if(!imageName.isEmpty){
                            network.imageToBeSearched(imageName)
                            network.fetchData()
                        }
                    }, label: {
                        Image(systemName: "magnifyingglass.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width:40,height: 40)
                    })
                }
                Divider()
                ScrollView{
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
                        ForEach(network.images){imageData in
                            AsyncImage(url: URL(string:imageData.previewURL)){
                                phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100,height: 100)
                                        .onLongPressGesture(minimumDuration: 0.5) {
                                            selectedImage = imageData
                                            showingPopup = true
                                        }
                                case .failure(_):
                                    Image(systemName: "xmark.circle")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .popover(isPresented: $showingPopup, content: {
            PopupView(imageData: $selectedImage, showingPopup: $showingPopup)
        })
    }
}

//#Preview {
//    ContentView(network:)
//}
