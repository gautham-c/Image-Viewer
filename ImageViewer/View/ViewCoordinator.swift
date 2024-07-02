//
//  ViewCoordinator.swift
//  ImageViewer
//
//  Created by Gautham C on 7/2/24.
//

import SwiftUI

struct ViewCoordinator: View {
    @State var isSplashActive = true
    @ObservedObject var network = NetworkManager(searchImage: "")
    var body: some View {
        if !isSplashActive {
            ContentView(network: network)
        } else {
            SplashScreen(isSplashActive: $isSplashActive, network: network)
        }
    }
}

#Preview {
    ViewCoordinator()
}
