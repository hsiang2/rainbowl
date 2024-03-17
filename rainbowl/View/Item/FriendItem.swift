//
//  FriendItem.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/16.
//

import SwiftUI

struct FriendItem: View {
    @StateObject var viewModel = SocialViewModel()
    let user: User
        
//    let status: String
    
    init(viewModel: SocialViewModel = SocialViewModel(), user: User) {
        self.user = user
//        self.status = viewModel.fetchFriendStatus(user: AuthViewModel.shared.currentUser?.id ?? "")
    }
        var body: some View {
            VStack {
                GameSnapshotView(user: user)
                    .frame(width: 2358, height: 1825)
                    .cornerRadius(350)
                    .scaleEffect(0.12)
                    .frame(height: 250)

                HStack {
                    Image("\(user.avatar)_彩色")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .frame(width: 55, height: 55)
                        .background(Color(red: COLORS[user.avatarColor][0]/255, green: COLORS[user.avatarColor][1]/255, blue: COLORS[user.avatarColor][2]/255))
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(red: 87/255, green: 87/255, blue: 87/255))
    //                    Text(user.fullname)
    //                        .font(.system(size: 14))
                    }
//                    .padding(.bottom, 50)
                    Spacer()
                    Button(action: {
                        // 未完成
                    }, label: {
                            Text("送禮")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 50, height: 50)
                                .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                .cornerRadius(50)

                    })
                    Button(action: {
                        viewModel.deleteFriend(friendId: user.id ?? "")
                    }, label: {
                            Text("解除")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 50, height: 50)
                                .background(Color(red: 167/255, green: 165/255, blue: 165/255))
                                .cornerRadius(50)

                    })
                }.padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
            
            }.padding(.bottom, 30)
        }
}

//#Preview {
//    FriendItem()
//}
