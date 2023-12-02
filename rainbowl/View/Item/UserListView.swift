//
//  UserListView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var viewModel = SearchUserViewModel()
    @Binding var searchText: String
    
    var users: [User] {
        return searchText.isEmpty ? viewModel.users : viewModel.filteredUsers(searchText)
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(destination: LazyView(SocialGameView(user: user)), label: {
                        UserItem(user: user)
                            .padding(.leading)
                    })
                }
            }
        }
    
    }
}

//struct UserListView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserListView()
//    }
//}
