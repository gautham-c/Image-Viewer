//
//  SplashScreen.swift
//  ImageViewer
//
//  Created by Gautham C on 6/27/24.
//

import SwiftUI

struct SplashScreen: View {
    
    @Binding var isSplashActive : Bool
    var network : NetworkManager
    
    var body: some View {
        ZStack{
            Image("image")
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.0){
                self.isSplashActive = false
                network.fetchData()
            }
        }
    }
}


