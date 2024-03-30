//
//  MainTabView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainTabView: View {
//    @StateObject private var viewModel = DateChangeViewModel()
    
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var socialViewModel: SocialViewModel
//    @StateObject var socialViewModel = SocialViewModel(backpackViewModel: backpackViewModel)
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
                        Image("money_bg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                            .padding()
                        Text(String(AuthViewModel.shared.currentUser?.money ?? 0)).padding(.trailing, 20).padding(.bottom, 3)
                    }
                    Spacer()
                    Button(action: {
                                openMailbox.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        ZStack {
                            Image(systemName: "envelope")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .padding()
//                            Text("\(socialViewMode.fetchNotificationNumber())")
//                                .font(.system(size: 14))
//                                .frame(width: 25, height: 25)
////                                .padding(10)
//                                      .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
//                                      .background(Circle().fill(Color(red: 187/255, green: 129/255, blue: 111/255)))
//                                .offset(x: 18, y: -10)
                            let unreadCount = socialViewModel.newNotificationsCount()
                                   if unreadCount > 0 {
                                       Text("\(unreadCount)")
                                           .font(.system(size: 12))
                                           .fontWeight(.bold)
                                           .foregroundColor(.red)
                                           .padding(6)
                                           .background(Color.white)
                                           .clipShape(Circle())
                                           .offset(x: 12, y: -12)
                                   }
                        }
                       
                    })
                    .fullScreenCover(isPresented: $openMailbox) {
                        MailboxView(show: $openMailbox, socialViewModel: socialViewModel)
                    }
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
                                openShare.toggle()
                        SoundPlayer.shared.playIconSound()
                    }, label: {
                        Image("相機")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
//                            .fullScreenCover(isPresented: $openShare) {
//                                ShareView(user: user, show: $openShare)
//                            }
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
            }
     
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name.NSCalendarDayChanged).receive(on: DispatchQueue.main)) { _ in
            // do what you want as soon as the day changes (23:59:59 --> 00:00:00)
            print("換日！")
            AuthViewModel.shared.updateColors()
            isEarnedMoney = false
        }
//        .onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged)) { _ in
//            if !Calendar.current.isDate(previousDate, inSameDayAs: viewModel.currentDate) {
//                viewModel.handleDateChange()
//                previousDate = viewModel.currentDate
//                print("date change")
//            }
//        }
    }
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
