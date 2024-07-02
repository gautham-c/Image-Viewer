//
//  NetworkManager.swift
//  ImageViewer
//
//  Created by Gautham C on 6/26/24.
//

import Foundation

class NetworkManager : ObservableObject {
    
    init(searchImage: String) {
        self.searchImage = nil
    }
    
    var searchImage : String?
    var encodedImageName : String {
        (searchImage?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) ?? " "
    }
    let urlString = "\(Constants.initialUrl)?key=\(Constants.apiKey)"
    
    @Published var images = [ImageData]()
    
    func imageToBeSearched(_ searchImage : String) {
        self.searchImage = searchImage
    }
    
    func fetchData(){
        let url = URL(string: "\(urlString)&q=\(encodedImageName)")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
                    if (error == nil){
                        let decoder = JSONDecoder()
                        if let safeData = data {
                            do {
                                let results = try decoder.decode(Images.self, from: safeData)
                                DispatchQueue.main.async {
                                    self.images = results.hits
                                }
                            } catch {
                                print(error)
                            }
                        }
                    }
                }
        task.resume()

    }
}
