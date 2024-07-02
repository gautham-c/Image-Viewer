//
//  ImageData.swift
//  ImageViewer
//
//  Created by Gautham C on 6/26/24.
//

import Foundation

struct Images : Decodable {
    let hits : [ImageData]
    let totalHits : Int
    var totalColumns : Int {
        return (totalHits - 1) / 3
    }
}

struct ImageData : Decodable, Identifiable {
    
    let id : Int
    let previewURL : String
    let largeImageURL : String
    let likes : Int
    let user : String
    let tags : String
    var tagArray : [String] {
        return tags.split(separator: ", ").map(String.init)
    }
}
