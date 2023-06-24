//
//  MainTabView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    @State private var openRecord = false
    @State private var openCollection = false
    @State private var openCalendar = false
    @State private var openShop = false
    @State private var openSetting = false
    
    var body: some View {
        ZStack {
            GameView()
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        AuthViewModel.shared.signout()
//                                openSetting.toggle()
                    }, label: {
                        Image("設定")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .padding()
                    })
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
                        RecordView(show: $openRecord)
                    }
                }
            }
     
        }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
