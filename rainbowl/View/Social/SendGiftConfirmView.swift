//
//  SendGiftConfirmView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/23.
//

import SwiftUI

@available(iOS 16.4, *)
struct SendGiftConfirmView: View {
    @Binding var show: Bool
    @StateObject var viewModel: SocialViewModel
    let creature: Creature
    let message: String
    let friendId: String
    let friendName: String
    
    var body: some View {
        ZStack {
            //            Color(red: 230/255, green: 229/255, blue: 222/255)
            //                .ignoresSafeArea()
            //            ScrollView {
            VStack(alignment: .center) {
                HStack {
                    Spacer()
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
                Spacer()
                PostcardView(creatureName: creature.name, message: message, receiver: friendName)
                Button {
                    SoundPlayer.shared.playClickSound()
                    viewModel.sendGift(friend: friendId, creature: creature, message: message)
                    show = false
                } label: {
                    ZStack {
                        Image("按鈕_確認送出")
                            .resizable().scaledToFit().frame(width: 126, height: 48)
                        Text("確認送出")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 36/255, green: 18/255, blue: 13/255))
                            .padding(.bottom, 6)
                    }
                   
                }.padding(.top, 40)
                Spacer()
            }
        }.presentationBackground(Color(red: 8/255, green: 8/255, blue: 8/255).opacity(0.64))
//                .padding(.horizontal, 30)
//                    .padding(.vertical, 20)
//            }
//            
//        }.presentationDetents([.fraction(0.8)])
        
    }
}


//#Preview {
//    SendGiftConfirmView()
//}
