//
//  UserItem.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct UserItem: View {
    @ObservedObject var socialViewModel: SocialViewModel
    let user: User
        
    var status: String
    
    init(socialViewModel: SocialViewModel, user: User) {
        self.socialViewModel = socialViewModel
        self.user = user
        self.status = socialViewModel.fetchFriendStatus(user: user.id ?? "")

    }
    var body: some View {
        VStack {
            GameSnapshotView(user: user, socialViewModel: socialViewModel)
                .scaleEffect(0.2)
                .scaledToFit()
                .frame(width: 318, height: 217)
                .cornerRadius(35)

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
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 59/255, green: 65/255, blue: 60/255))
                }.padding(.leading, 10)
                Spacer()
                Button(action: {
                    if (status == "") {
                        socialViewModel.sendInvitation(invitee: user.id ?? "")
                        SoundPlayer.shared.playIconSound()
                        
                    } else if (status == "request") {
                        socialViewModel.acceptInvitation(inviter: user.id ?? "")
                        SoundPlayer.shared.playIconSound()
                    }
                        
                    
                }, label: {
                    if (status == "") {
                        ZStack {
                            Image("按鈕_查看接受送禮")
                                .resizable()
                                .scaledToFit()
                            Text("加好友")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                .padding(.bottom, 3)
                        }.frame(width: 77, height: 33)
                    } else if  (status == "request") {
                        ZStack {
                            Image("按鈕_接受")
                                .resizable()
                                .scaledToFit()
                            Text("接受")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                .padding(.bottom, 3)
                        }.frame(width: 77, height: 33)
                    } else if (status == "pending") {
                        Text("已邀請")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(Color(red: 189/255, green: 177/255, blue: 170/255))
                        .frame(width: 77, height: 30)
                        .background(Color(red: 227/255, green: 218/255, blue: 212/255))
                        .cornerRadius(9)
                    }
                    else {
                        Text("好友")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(red: 213/255, green: 168/255, blue: 143/255))
                            .frame(width: 77, height: 30)
                            .overlay(
                                RoundedRectangle(cornerRadius: 9)
                                    .stroke(Color(red: 213/255, green: 168/255, blue: 143/255), lineWidth: 1.3)
                            )
                    }
                })
            }.padding(.init(top: 20, leading: 55, bottom: 0, trailing: 55))
            
        }.padding(.vertical, 25)
    }
}


//struct UserItem_Previews: PreviewProvider {
//    static var previews: some View {
//        UserItem()
//    }
//}
