//
//  rainbowlApp.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI
import Firebase

@main
struct rainbowlApp: App {
    
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(AuthViewModel.shared)
        }
    }
}
