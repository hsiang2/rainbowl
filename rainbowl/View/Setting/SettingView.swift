//
//  SettingView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/24.
//

import SwiftUI

struct SettingView: View {
    let user: User
    @State private var openKnowledge = false
    
    @Binding var show: Bool
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 225/255, green: 232/255, blue: 234/255)
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
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                                .padding()
                                
                        }
                    }
                VStack {
                            Image("\(user.avatar)_彩色")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 66, height: 66)
                            .frame(width: 120, height: 120)
                            .background(Color(red: COLORS[user.avatarColor][0]/255, green: COLORS[user.avatarColor][1]/255, blue: COLORS[user.avatarColor][2]/255))
                            .clipShape(Circle())

                        VStack {
                            Text(user.username)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Color(red: 25/255, green: 50/255, blue: 74/255))
                            Text(verbatim:user.email)
                                .font(.system(size: 16))
                                .foregroundColor(Color(red: 25/255, green: 50/255, blue: 74/255).opacity(0.7))
                                .padding(.top, 0.5)
                        }.padding(.top, 10)
                    
                    Button(action: {
                        openKnowledge.toggle()
                        SoundPlayer.shared.playClickSound()
                    }, label: {
                        Text("認識彩虹飲食")
                            .font(.system(size: 20))
                            .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                            .frame(width: 340, height: 60)
                            .background(Color(red: 153/255, green: 180/255, blue: 184/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 108/255, green: 127/255, blue: 145/255).opacity(0.3), radius: 6, x: 0, y: 4)
                            .padding(.top, 70)
                    }).padding(.top, 20)
                        .padding(.bottom, 20)
                    .fullScreenCover(isPresented: $openKnowledge) {
                        KnowledgeView(show: $openKnowledge)
                    }
                        
                    NavigationLink(
                        destination: EditUserView(user: user).navigationBarHidden(true),
                        label: {
                            Text("編輯個人資料")
                                .font(.system(size: 20))
                                .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                                .frame(width: 340, height: 60)
                                .background(Color(red: 153/255, green: 180/255, blue: 184/255))
                                .cornerRadius(9)
                                .shadow(color: Color(red: 108/255, green: 127/255, blue: 145/255).opacity(0.3), radius: 6, x: 0, y: 4)
//                                .padding(.top, 70)
                        }
                    ).padding(.bottom, 20)

                    Button(action: {
                        AuthViewModel.shared.signout()
                        SoundPlayer.shared.playClickSound()
                    }, label: {
                        Text("登出")
                            .font(.system(size: 20))
                            .foregroundColor(Color(red: 25/255, green: 50/255, blue: 74/255))
                            .frame(width: 340, height: 60)
                            .background(Color(red: 239/255, green: 241/255, blue: 243/255))
                            .cornerRadius(9)
                            .shadow(color: Color(red: 108/255, green: 127/255, blue: 145/255).opacity(0.3), radius: 6, x: 0, y: 4)
                    }).padding(.top, 20)
                    Spacer()
                }.padding(.top, 70)
            }
        }
       
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView(show: .constant(true))
//    }
//}
