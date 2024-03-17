//
//  FriendListView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/16.
//

import SwiftUI

@available(iOS 17.0, *)
struct FriendListView: View {
    @ObservedObject var viewModel = SocialViewModel()
    @Binding var searchText: String
    
    var friendList: [User] {
        return searchText.isEmpty ? viewModel.fetchRealFriendList() : viewModel.filteredFriends(searchText)
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(friendList) { friend in
                    
                    NavigationLink(destination: LazyView(SocialGameView(user: friend)), label: {
                        FriendItem(user: friend)
                            .padding(.leading)
                    })
                }
            }
        }
    
    }
}
