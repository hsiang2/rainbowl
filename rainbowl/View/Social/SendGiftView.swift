//
//  SendGiftView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/17.
//

import SwiftUI

struct SendGiftView: View {
    @Binding var show: Bool
    let friendId: String
    let friendName: String
    @ObservedObject var backpackViewModel: BackpackViewModel
    @ObservedObject var socialViewModel: SocialViewModel
    
    @State private var message: String = ""
    @State private var openBackpack = false
    @State private var targetCreature: Creature?
    
    @State private var openNextPage = false
    
    var body: some View {
        ZStack {
            Color(red: 230/255, green: 229/255, blue: 222/255)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                   
                    Text("送禮物給\(friendName)").font(.system(size: 20, weight: .medium)).foregroundColor(Color(red: 120/255, green: 97/255, blue: 61/255))
                        .padding(.vertical, 30)
                
                
                        Text("禮物")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        Button(action: {
                            openBackpack.toggle()
                            
                        }, label: {
                            Text("選擇動植物")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 100, height: 50)
                                .background(Color(red: 187/255, green: 129/255, blue: 111/255))
                                .cornerRadius(50)

                        }).padding(.bottom, 30)
                        .sheet(isPresented: $openBackpack) {
                            ZStack {
                                Color(red: 230/255, green: 229/255, blue: 222/255)
                                    .ignoresSafeArea()
                                BackpackView(backpackViewModel: backpackViewModel, mode: "gift", targetCreature: $targetCreature, show: Binding<Bool?>(get: { self.openBackpack }, set: { self.openBackpack = $0 ?? false }))
                            }.presentationDetents([.fraction(0.8)])
                            
                        }
                    ZStack {
                        Image("box_bg")
                        if ((targetCreature) != nil) {
                            Image("\(targetCreature?.name ?? "")_彩色")
                                    .resizable().scaledToFit().frame(width: 70, height: 70).saturation(0)
                            }
                    }
                   
                       
                        Text("留言")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        TextEditor(text: $message)
                            .multilineTextAlignment(.leading
                            ).scrollContentBackground(.hidden).padding(5).overlay(
                                RoundedRectangle(cornerRadius: 25)
                                  .stroke(Color(red: 139/255, green: 128/255, blue: 101/255), lineWidth: 1)
                                )
                            .frame(height: 200)
                Spacer()
                    Button {
                        openNextPage.toggle()
                        SoundPlayer.shared.playClickSound()
                    } label: {
                        Text("下一步")
                            .font(.headline)
                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .frame(width: 314, height: 48)
                            .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                            .padding(.top, 42)
                    }.sheet(isPresented: $openNextPage) {
                        SendGiftConfirmView(show: $show, viewModel: socialViewModel, creature: targetCreature!, message: message, friendId: friendId)
                    }
                    .disabled(targetCreature == nil || message == "")
                }.padding(.horizontal, 30)
                    .padding(.vertical, 20)
            }
            
        }.presentationDetents([.fraction(0.8)])
        
    }
}

//#Preview {
//    SendGiftView()
//}