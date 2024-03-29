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
//    {
//        return socialViewModel.fetchFriendStatus(user: user.id ?? "")
//    }
    
    init(socialViewModel: SocialViewModel, user: User) {
        self.socialViewModel = socialViewModel
        self.user = user
//        self.status = socialViewModel.fetchFriendStatus(user: AuthViewModel.shared.currentUser?.id ?? "")
        self.status = socialViewModel.fetchFriendStatus(user: user.id ?? "")

    }
        var body: some View {
            VStack {
                GameSnapshotView(user: user, socialViewModel: socialViewModel)
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
                    }.padding(.leading, 10)
//                    .padding(.bottom, 50)
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
                            Text("加入好友")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 90, height: 50)
                                .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                .cornerRadius(50)
                        } else if  (status == "request") {
                            Text("接受邀請")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 90, height: 50)
                                .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                .cornerRadius(50)
                        } else if (status == "pending") {
                            Text("已邀請")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 90, height: 50)
                                .background(Color(red: 167/255, green: 165/255, blue: 165/255))
                                .cornerRadius(50)
                        } 
                        else {
                            Text("好友")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 90, height: 50)
                                .background(Color(red: 167/255, green: 165/255, blue: 165/255))
                                .cornerRadius(50)
                        }
                    })
                }.padding(.init(top: 0, leading: 50, bottom: 0, trailing: 50))
                

            
            }.padding(.bottom, 30)
        }
//            HStack {
////                KFImage(URL(string: user.profileImageUrl))
//                Image("刺蝟_彩色")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 48, height: 48)
//                    .clipShape(Circle())
//
//                VStack(alignment: .leading) {
//                    Text(user.username)
//                        .font(.system(size: 14, weight: .semibold))
////                    Text(user.fullname)
////                        .font(.system(size: 14))
//                }
//                Spacer()
//            }
        }


//struct UserItem_Previews: PreviewProvider {
//    static var previews: some View {
//        UserItem()
//    }
//}
