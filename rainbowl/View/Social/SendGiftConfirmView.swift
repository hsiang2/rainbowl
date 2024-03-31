//
//  SendGiftConfirmView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/23.
//

import SwiftUI

struct SendGiftConfirmView: View {
    @Binding var show: Bool
    @StateObject var viewModel: SocialViewModel
    let creature: Creature
    let message: String
    let friendId: String
    
    var body: some View {
        ZStack {
            Color(red: 230/255, green: 229/255, blue: 222/255)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    PostcardView(creatureName: creature.name, message: message)
                
    
                Spacer()
                    Button {
                        SoundPlayer.shared.playClickSound()
                        viewModel.sendGift(friend: friendId, creature: creature, message: message)
                        show = false
                    } label: {
                        Text("寄出")
                            .font(.headline)
                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .frame(width: 314, height: 48)
                            .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                            .padding(.top, 42)
                    }
                }.padding(.horizontal, 30)
                    .padding(.vertical, 20)
            }
            
        }.presentationDetents([.fraction(0.8)])
        
    }
}


//#Preview {
//    SendGiftConfirmView()
//}
