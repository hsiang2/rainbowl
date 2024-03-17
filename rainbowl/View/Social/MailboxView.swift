//
//  MailboxView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/13.
//

import SwiftUI

struct MailboxView: View {
    @Binding var show: Bool
    
    @StateObject var socialViewModel = SocialViewModel()
//    @StateObject var searchUserViewModel = SearchUserViewModel()
    
    var notificationList: [UserNotification] {
        return socialViewModel.notificationList
    }

//   @State var searchText = ""
//   @State var inSearchMode = false
//   @StateObject var viewModel = SearchUserViewModel()

    var body: some View {
        NavigationView {
            
            ZStack {
                Color(red: 233/255, green: 230/255, blue: 221/255)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            show = false
                            SoundPlayer.shared.playCloseSound()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                            
                        }
                    }
                List {
                    ForEach (notificationList) { notification in
                        HStack {
                           
                            Text(socialViewModel.fetchNameById(user: notification.sender ))
                            + Text( notification.type == "friendAccept" ? "已接受您的交友邀請" : "向您送出交友邀請")
                                .font(.system(size: 16))
                                
                         
                            //                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            Spacer()
                            if ((notification.type == "friendInvitation")) {
                                Button {
                                    if(socialViewModel.fetchFriendStatus(user: notification.sender) == "request") {
                                        socialViewModel.acceptInvitation(inviter: notification.sender)
                                        SoundPlayer.shared.playCloseSound()
                                    }
                                   
                                } label: {
                                    if (socialViewModel.fetchFriendStatus(user: notification.sender) == "request") {
                                        Text("確認")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                            .frame(width: 80, height: 50)
                                            .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                            .cornerRadius(50)
                                    } else {
                                        Text("已接受")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                            .frame(width: 80, height: 50)
                                            .background(Color(red: 167/255, green: 165/255, blue: 165/255))
                                            .cornerRadius(50)
                                    }
                                }
                            }
                           
                        }.swipeActions(allowsFullSwipe: false) {
                            Button {
                                socialViewModel.deleteNotification(id: notification.id ?? "")
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                            }
                            .tint(Color(red: 228/255, green: 126/255, blue: 83/255))
                            
                        }
                        .frame(height: 70)
                    }.listRowBackground(Color(white: 0, opacity: 0))
                        .background(Color.clear)
                
                }.listStyle(.plain)
                    .environment(\.defaultMinListRowHeight, 70)
                    .padding(.top, 80)
                
            }
        }
    }
}

#Preview {
    MailboxView(show: .constant(true))
}
