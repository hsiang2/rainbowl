//
//  MainTabView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

@available(iOS 17.0, *)
struct MainTabView: View {
    @StateObject private var viewModel = DateChangeViewModel()
    @State private var previousDate = Date()
    
    
    let user: User
    @State private var openRecord = false
    @State private var openCollection = false
    @State private var openCalendar = false
    @State private var openShop = false
    @State private var openSetting = false
    @State private var openSocial = false
    
    var body: some View {
        ZStack {
            GameView(user: user)
            VStack {
                HStack {
                    ZStack {
                        Image("money_bg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110)
                            .padding()
                        Text(String(AuthViewModel.shared.currentUser?.money ?? 0))
                    }
                    Spacer()
                    Button(action: {
                                openSocial.toggle()
                    }, label: {
                        Image("社群")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openSocial) {
                        SocialView(show: $openSocial)
                    }
                    Button(action: {
//                        AuthViewModel.shared.signout()
                        openSetting.toggle()
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
    //                            openRecord.toggle()
                    }, label: {
                        Image("相機")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
    //                        .sheet(isPresented: $openRecord) {
    //                            RecordView(show: $openRecord)
    //                        }
                }
                HStack {
                    Button(action: {
                        openShop.toggle()
                    }, label: {
                        Image("商店")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .fullScreenCover(isPresented: $openShop) {
                        ShopView(show: $openShop)
                    }
                    Button(action: {
                        openCollection.toggle()
                    }, label: {
                        Image("蒐集")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
                    .sheet(isPresented: $openCollection) {
                        CollectionView(show: $openCollection)
                    }
                    Spacer()
                    Button(action: {
                        openRecord.toggle()
                    }, label: {
                        Image("調色盤")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 76, height: 76)
                            .padding()
                    })
                    .sheet(isPresented: $openRecord) {
                        RecordView(user: user, show: $openRecord)
                    }
                }
            }
     
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
