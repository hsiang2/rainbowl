//
//  FriendListView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/16.
//

import SwiftUI

@available(iOS 17.0, *)
struct FriendListView: View {
    @ObservedObject var socialViewModel: SocialViewModel
    @ObservedObject var backpackViewModel: BackpackViewModel
    @Binding var searchText: String
    
    var friendList: [User] {
        return searchText.isEmpty ? socialViewModel.fetchRealFriendList() : socialViewModel.filteredFriends(searchText)
    }
    
    var body: some View {
        
        ScrollView {
            LazyVStack {
                ForEach(friendList) { friend in
                    
                    NavigationLink(destination: LazyView(SocialGameView(user: friend, viewModel: socialViewModel)), label: {
                        FriendItem(socialViewModel: socialViewModel, backpackViewModel: backpackViewModel, user: friend)
                            .padding(.leading)
                    })
                }
            }
        }
    
    }
}
