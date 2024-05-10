//
//  MainTabView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainTabView: View {
    
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var socialViewModel: SocialViewModel
    let user: User
    @State private var previousDate = Date()
    @State private var openRecord = false
    @State private var openCollection = false
    @State private var openCalendar = false
    @State private var openShop = false
    @State private var openSetting = false
    @State private var openSocial = false
    @State private var openMailbox = false
    
    @State private var openShare = false
    
    @State private var isEarnedMoney = false
    
    init(user: User) {
        self.user = user
        let sharedBackpackViewModel = BackpackViewModel()
        self.backpackViewModel = sharedBackpackViewModel
        self.socialViewModel = SocialViewModel(backpackViewModel: sharedBackpackViewModel)
    }

    
    var body: some View {
        ZStack {
            GameView(user: user, backpackViewModel: backpackViewModel)
            VStack {
                HStack {
                    ZStack {
                        Image("錢框")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 89)
                            .padding()
                        Text(String(AuthViewModel.shared.currentUser?.money ?? 0)).font(.system(size: 16)).foregroundColor(Color(red: 45/255, green: 49/255, blue: 66/255)).padding(.trailing, 20)
                    }
                    Spacer()
                    Button(action: {
                                openSocial.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("社群")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openSocial) {
                        SocialView(show: $openSocial, socialViewModel: socialViewModel, backpackViewModel: backpackViewModel)
                    }
                    Button(action: {
                        openSetting.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("設定")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openSetting) {
                        SettingView(user: user, show: $openSetting)
                    }
                }
                HStack{
                    Button(action: {
                                openShare.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("相機")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                            .fullScreenCover(isPresented: $openShare) {
                                ShareView(user: user, show: $openShare, socialViewModel: socialViewModel)
                            }
                    Spacer()
                }.padding(.top, -20)
                Spacer()
                HStack {
                    Button(action: {
                        openCalendar.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("月曆")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openCalendar) {
                        CalendarView(show: $openCalendar)
                    }
                    Spacer()
                    Button(action: {
                                openMailbox.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        ZStack {
                            Image("信箱")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .padding()
                            let unreadCount = socialViewModel.newNotificationsCount()
                                   if unreadCount > 0 {
                                       Text("\(unreadCount)")
                                           .font(.system(size: 16))
                                           .fontWeight(.bold)
                                           .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                           .padding(8)
                                           .background(Circle().fill(Color(red: 205/255, green: 93/255, blue: 57/255)))
                                           .clipShape(Circle())
                                           .offset(x: 22, y: -22)
                                   }
                        }
                       
                    })
                    .fullScreenCover(isPresented: $openMailbox) {
                        MailboxView(show: $openMailbox, socialViewModel: socialViewModel)
                    }
                  
                }
                HStack {
                    Button(action: {
                        openShop.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("商店")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openShop) {
                        ShopView(show: $openShop, backpackViewModel: backpackViewModel)
                    }
                    Button(action: {
                        openCollection.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("蒐集")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .sheet(isPresented: $openCollection) {
                        CollectionView(show: $openCollection, backpackViewModel: backpackViewModel)
                    }
                    Spacer()
                    Button(action: {
                        openRecord.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("調色盤")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 76)
                            .padding()
                    })
                    .sheet(isPresented: $openRecord) {
                        RecordView(isEarnedMoney: $isEarnedMoney, user: user, show: $openRecord)
                    }
                }
            }.padding(.horizontal, 10)
     
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.NSCalendarDayChanged).receive(on: DispatchQueue.main)) { _ in
            // do what you want as soon as the day changes (23:59:59 --> 00:00:00)
            print("換日！")
            AuthViewModel.shared.updateColors()
            isEarnedMoney = false
        }

    }
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
