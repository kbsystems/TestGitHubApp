//
//  GitHubAppApp.swift
//  GitHubApp
//
//  Created by Jan Binkiewicz on 29/07/2022.
//

import SwiftUI

@main
struct GitHubAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserViewModel())
        }
    }
}
