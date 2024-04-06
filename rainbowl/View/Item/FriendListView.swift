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
        
        if (friendList.count == 0) {
            VStack {
                Image("尚無好友")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 141)
                    .padding(.bottom, 47)
                    .padding(.top, 100)
                
                Text("尚無好友")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(Color(red:136/255, green: 109/255, blue: 91/255))
                    .padding(.bottom, 18)
                
                Text("這裡會顯示您已添加的好友，透過探索發現更多新朋友")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red:136/255, green: 109/255, blue: 91/255).opacity(0.75))
                    .multilineTextAlignment(.center)
                    .frame(width: 280)
                
            }
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(friendList) { friend in
                        
                        NavigationLink(destination: LazyView(SocialGameView(user: friend, viewModel: socialViewModel)), label: {
                            FriendItem(socialViewModel: socialViewModel, backpackViewModel: backpackViewModel, user: friend)
    //                            .padding(.leading)
                        })
                    }
                }
            }
        }
        
       
    
    }
}
