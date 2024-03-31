//
//  MailboxView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/13.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class SelectedNotificationManager: ObservableObject {
    @Published var selectedNotification: UserNotification?
}

struct MailboxView: View {
    @Binding var show: Bool
    @State private var openPostCard = false
    @ObservedObject var selectedNotificationManager = SelectedNotificationManager()
    @ObservedObject var socialViewModel: SocialViewModel
    
    var notificationList: [UserNotification] {
        return socialViewModel.notificationList
    }

    var body: some View {
        NavigationView {
            
            ZStack {
                Color(red: 233/255, green: 235/255, blue: 226/255)
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
                            let color = socialViewModel.fetchAvatarColorById(user: notification.sender)
                            HStack{
                                    Image("\(socialViewModel.fetchAvatarById(user: notification.sender))_彩色")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 30, height: 30)
                                        .frame(width: 55, height: 55)
                                        .background(Color(red: COLORS[color][0]/255, green: COLORS[color][1]/255, blue: COLORS[color][2]/255))
                                        .clipShape(Circle())
                                    VStack(alignment: .leading) {
                                        Text(socialViewModel.fetchNameById(user: notification.sender ))
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(Color(red:59/255, green: 65/255, blue: 60/255))
                                            .padding(.bottom, 6)
                                        Text( notification.type == "friendAccept" ? "已接受您的交友邀請！" : notification.type == "friendInvitation" ? "已向您發出交友邀請！" : "向您送出一份禮物！")
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(Color(red:119/255, green: 119/255, blue: 119/255))
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text(timeAgo(timestamp: notification.timestamp))
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundColor(Color(red: 160/255, green: 168/255, blue: 161/255))
                                        
                                        if (notification.type == "friendInvitation") {
                                            Button {
                                                if(socialViewModel.fetchFriendStatus(user: notification.sender) == "request") {
                                                    socialViewModel.acceptInvitation(inviter: notification.sender)
                                                    SoundPlayer.shared.playCloseSound()
                                                }
                                                
                                            } label: {
                                                if (socialViewModel.fetchFriendStatus(user: notification.sender) == "request") {
                                                    ZStack {
                                                        Image("按鈕_查看接受送禮")
                                                            .resizable()
                                                            .scaledToFit()
//                                                            .frame(width: 77)
                                                        Text("接受")
                                                            .font(.system(size: 15, weight: .medium))
                                                            .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                                            .padding(.bottom, 3)
                                                    }.frame(width: 77, height: 33)
                                                    
                                                    
                                                } else {
                                                    Text("已接受")
                                                        .font(.system(size: 15, weight: .medium))
                                                        .foregroundColor(Color(red: 179/255, green: 179/255, blue: 175/255))
                                                        .frame(width: 77, height: 30)
                                                        .background(Color(red: 230/255, green: 230/255, blue: 224/255))
                                                        .cornerRadius(9)
                                                }
                                            }
                                        } else if (notification.type == "gift") {
                                            
                                            Button {
                                                selectedNotificationManager.selectedNotification = notification
                                                openPostCard = true
                                            } label: {
                                                ZStack {
                                                    Image("按鈕_查看接受送禮")
                                                        .resizable()
                                                        .scaledToFit()
                                                        
                                                    Text("查看")
                                                        .font(.system(size: 15, weight: .medium))
                                                        .foregroundColor(Color(red: 83/255, green: 83/255, blue: 83/255))
                                                        .padding(.bottom, 3)
                                                }
                                                .frame(width: 77, height: 33)
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
                            .padding()
                            .frame(height: 82)
                            .background(Color(red: 244/255, green: 247/255, blue: 246/255))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 231/255, green: 227/255, blue: 216/255), lineWidth: 2)
                            )
                            .listRowSeparator(.hidden)
                            
                        }.listRowBackground(Color(white: 0, opacity: 0))
                            .background(Color.clear)
                        
                        
                    }.listStyle(.plain)
                        .environment(\.defaultMinListRowHeight, 82)
                        .padding(.top, 80)
                        .padding(.horizontal, 16)
            }
            .onAppear {
                           // Mark unread notifications as read when the mailbox view appears
                socialViewModel.markUnreadNotificationsAsRead()
            }
            .fullScreenCover(isPresented: $openPostCard) {
                ZStack {
                    Color(red: 225/255, green: 232/255, blue: 234/255)
                        .ignoresSafeArea()
                        .overlay(alignment: .topTrailing) {
                            Button {
                                openPostCard = false
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
                    PostcardView(creatureName: selectedNotificationManager.selectedNotification?.creatureName ?? "", message: selectedNotificationManager.selectedNotification?.message ?? "")
                }
            }
            
        }
       
    }
}

func timeAgo(timestamp: Timestamp) -> String {
    let date = timestamp.dateValue()
    let seconds = Int(Date().timeIntervalSince(date))
    let interval = seconds / 31536000

    if interval > 1 {
        return "\(interval) 年前"
    }
    if interval == 1 {
        return "\(interval) 年前"
    }

    let months = seconds / 2628000
    if months > 1 {
        return "\(months) 個月前"
    }
    if months == 1 {
        return "\(months) 個月前"
    }

    let days = seconds / 86400
    if days > 1 {
        return "\(days) 天前"
    }
    if days == 1 {
        return "\(days) 天前"
    }

    let hours = seconds / 3600
    if hours > 1 {
        return "\(hours) 小時前"
    }
    if hours == 1 {
        return "\(hours) 小時前"
    }

    let minutes = seconds / 60
    if minutes > 1 {
        return "\(minutes) 分鐘前"
    }
    if minutes == 1 {
        return "\(minutes) 分鐘前"
    }

    return "剛剛"
}

//#Preview {
//    MailboxView(show: .constant(true))
//}
