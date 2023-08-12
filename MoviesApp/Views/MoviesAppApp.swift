//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by Kiwi on 10/08/23.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    var body: some Scene {
        let viewModel = MoviesViewModel(netWorkService: NetworkService())
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
    
}
