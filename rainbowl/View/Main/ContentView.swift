//
//  ContentView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                if let user = viewModel.currentUser {
                    MainTabView(user: user)
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(AuthViewModel.shared)
    }
}
