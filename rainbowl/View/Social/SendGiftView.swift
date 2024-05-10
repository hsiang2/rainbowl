//
//  SendGiftView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/17.
//

import SwiftUI

@available(iOS 16.4, *)
struct SendGiftView: View {
    @Binding var show: Bool
    let friendId: String
    let friendName: String
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var socialViewModel: SocialViewModel
    
    @State private var message: String = ""
   
    @State private var targetCreature: Creature?
    
    @State private var openBackpack = false
    @State private var openNextPage = false
    
    var body: some View {
//        ZStack {
//            if (show) {
                ZStack {
                    Color(red: 242/255, green: 236/255, blue: 232/255)
                        .ignoresSafeArea()
                    VStack {
                        HStack {
                            Text("送禮物給 ").font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 112/255, green: 82/255, blue: 82/255))
                     
                            Text(friendName).font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 195/255, green: 114/255, blue: 89/255))
                            Spacer()
                        }.padding(30).frame(maxWidth: .infinity)
                            .background( Color(red: 251/255, green: 251/255, blue: 251/255).opacity(0.26))
                            .shadow(
                                color: Color(red: 192/255, green: 176/255, blue: 157/255).opacity(0.33),
                                radius: 11, x: 0, y: 1)
                            
                        ScrollView {
                            VStack(alignment: .leading) {
                               
                              
                            
                            
                                    Text("禮物")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(Color(red: 112/255, green: 94/255, blue: 82/255))
        //                                .padding(.top, 20)
                                
                                if ((targetCreature) == nil) {
                                    Button(action: {
                                        openBackpack.toggle()
                                        
                                    }, label: {
                                        Text("選擇動植物")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                            .frame(width: 116, height: 45)
                                            .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                            .cornerRadius(50)
                                        
                                    }).padding(.top, 16)
                                        .padding(.bottom, 30)
                                }
                                
                                if ((targetCreature) != nil) {
                                    ZStack {
                                        Image("box_bg")
                                        Image("\(targetCreature?.name ?? "")_彩色")
                                            .resizable().scaledToFit().frame(width: 70, height: 70).saturation(0)
                                    }
                                        .padding(.bottom, 25)
                                        .onTapGesture {
                                        openBackpack.toggle()
                                    }
                                }
                               
                                   
                                Text("留言")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(Color(red: 112/255, green: 94/255, blue: 82/255))
                                    .padding(.bottom, 15)
                                
                                ZStack(alignment: .leading) {
                                    Image("留言框\(message == "很高興認識你！" ? "_focused" : "" )")
                                        .resizable().scaledToFill().frame(height: 52)
                                    Text("很高興認識你！")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 98/255, green: 97/255, blue: 97/255).opacity(0.6))
                                        .padding(.bottom, 10)
                                        .padding(.leading, 18)
                                }.onTapGesture {
                                    message = "很高興認識你！"
                                }.padding(.bottom, 7)
                                
                                ZStack(alignment: .leading) {
                                    Image("留言框\(message == "希望你會喜歡這份禮物(♡˙︶˙♡)" ? "_focused" : "" )")
                                        .resizable().scaledToFill().frame(height: 52)
                                    Text("希望你會喜歡這份禮物(♡˙︶˙♡)")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color(red: 98/255, green: 97/255, blue: 97/255).opacity(0.6))
                                        .padding(.bottom, 10)
                                        .padding(.leading, 18)
                                }.onTapGesture {
                                    message = "希望你會喜歡這份禮物(♡˙︶˙♡)"
                                }.padding(.bottom, 17)
                               
                                VStack {
                                    ZStack(alignment: .topLeading) {
                                        if message.isEmpty {
                                            Text("撰寫自己的留言...")
                                                .font(.system(size: 14))
                                                .foregroundColor(Color(red: 196/255, green: 196/255, blue: 196/255).opacity(0.6))
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 20)
                                        }
                                        
                                        TextEditor(text: $message)
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 98/255, green: 97/255, blue: 97/255).opacity(0.6))
                                            .multilineTextAlignment(.leading)
                                            .scrollContentBackground(.hidden)
                                            .frame(height: 60)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 12)
                                            .onChange(of: message) { result in
                                                message = String(message.prefix(30))
                                            }
                                    }
         
                                    HStack {
                                        Spacer()
                                        Text("\(message.count)/30")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color(red: 187/255, green: 185/255, blue: 185/255).opacity(0.7))
                                            .padding(.horizontal, 20)
                                            .padding(.bottom, 18)
                                    }
                                }.frame(height: 112)
                                    .background(Color(red: 247/255, green: 247/255, blue: 247/255))
                                    .cornerRadius(7)
                                    
                            Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        openNextPage.toggle()
                                        SoundPlayer.shared.playClickSound()
                                    } label: {
                                        ZStack {
                                            Image("按鈕_確認\(targetCreature == nil || message == "" ? "_disabled" : "" )")
                                                .resizable().scaledToFit().frame(width: 126, height: 48)
                                            
                                            Text("確認")
                                                .font(.system(size: 16))
                                                .foregroundColor(targetCreature == nil || message == "" ? Color(red: 45/255, green: 49/255, blue: 66/255) : Color(red: 74/255, green: 57/255, blue: 13/255))
                                                .padding(.bottom, 6)
                                                
                                        }.padding(.top, 40)
                                       
                                    }
                                    .fullScreenCover (isPresented: $openNextPage) {
                                        SendGiftConfirmView(show: $show, viewModel: socialViewModel, creature: targetCreature!, message: message, friendId: friendId, friendName: friendName)
                                            
                                    }
                                    .disabled(targetCreature == nil || message == "")
                                }
                                
                            }.padding(.horizontal, 30)
                            .padding(.vertical, 20)
                        }
                    }
                    
                    
                }.presentationDetents([.fraction(0.8)])
                    .presentationCornerRadius(24)
                    .fullScreenCover(isPresented: $openBackpack) {
                        ZStack {
                            Color(red: 8/255, green: 8/255, blue: 8/255).opacity(0.01)
                               .ignoresSafeArea().onTapGesture {
                                openBackpack.toggle()
                            }
                            ZStack {
                                Color(red: 230/255, green: 229/255, blue: 222/255)
                                BackpackView(backpackViewModel: backpackViewModel, mode: "gift", targetCreature: $targetCreature, show: Binding<Bool?>(get: { self.openBackpack }, set: { self.openBackpack = $0 ?? false }))
                            }.frame(width: 360, height: 540).cornerRadius(33)
                        }.presentationBackground(.clear)
                    }
        
    }
}

//#Preview {
//    SendGiftView()
//}
