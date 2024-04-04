//
//  FriendItem.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/16.
//

import SwiftUI

@available(iOS 16.4, *)
struct FriendItem: View {
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var socialViewModel: SocialViewModel
    let user: User
        
//    let status: String
    @State private var openSendGift = false
    
    
    init(socialViewModel: SocialViewModel,  backpackViewModel: BackpackViewModel, user: User) {
        self.socialViewModel = socialViewModel
        self.backpackViewModel = backpackViewModel
        self.user = user
//        self.status = viewModel.fetchFriendStatus(user: AuthViewModel.shared.currentUser?.id ?? "")
    }
        var body: some View {
            ZStack {
                VStack {
                    ZStack(alignment: .topLeading) {
                        
                        GameSnapshotView(user: user, socialViewModel: socialViewModel)
                        //                    .frame(width: 2358, height: 1825)
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
                            Text(user.username)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 87/255, green: 87/255, blue: 87/255))
                                .padding(.trailing, 25)
                        }
                        .frame(height: 55)
                        .background(.ultraThinMaterial)
                        .cornerRadius(50)
                        .padding(11)
                    }.frame(width: 318, height: 217)
                        .cornerRadius(35)
                    
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            openSendGift.toggle()
                            
                        }, label: {
                            ZStack {
                                Image("按鈕_查看接受送禮")
                                    .resizable()
                                    .scaledToFit()
                                Text("送禮")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                    .padding(.bottom, 3)
                            }.frame(width: 77, height: 33)
                        }).sheet(isPresented: $openSendGift) {
                            SendGiftView(show: $openSendGift, friendId: user.id ?? "", friendName: user.username, backpackViewModel: backpackViewModel, socialViewModel: socialViewModel)
                        }
                        Button(action: {
                            socialViewModel.deleteFriend(friendId: user.id ?? "")
                        }, label: {
                            ZStack {
                                Image("按鈕_移除")
                                    .resizable()
                                    .scaledToFit()
                                Text("移除")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                    .padding(.bottom, 3)
                            }.frame(width: 77, height: 33)
                            
                        })
                    }.padding(.init(top: 20, leading: 55, bottom: 0, trailing: 55))
                    
                }.padding(.vertical, 25)
//                if (openBackpack) {
//                    SendGiftConfirmView(show: $show, viewModel: socialViewModel, creature: targetCreature!, message: message, friendId: friendId)
//                        
//                }
            }
        }
}

//#Preview {
//    FriendItem()
//}
