//
//  SwiftAuthApp.swift
//  SwiftAuth
//
//  Created by Ashraf Hatia on 10/03/24.
//

import SwiftUI
import Firebase

@main
struct SwiftAuthApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
