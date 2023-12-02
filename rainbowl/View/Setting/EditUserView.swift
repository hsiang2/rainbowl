//
//  EditUserView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/2.
//

import SwiftUI

struct EditUserView: View {
    let user: User
    
    @State private var email: String
    @State private var username: String
    
    @State private var avatar: String
    @State private var avatarColor: Int
    
    init(user: User) {
        self.user = user
        _email = State(initialValue: user.email)
        _username = State(initialValue: user.username)
        _avatar = State(initialValue: user.avatar)
        _avatarColor = State(initialValue: user.avatarColor)
    }
    
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State private var openAvatar = false
    
    var body: some View {
        
        ZStack {
            Color(red: 241/255, green: 240/255, blue: 234/255)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        mode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding()
                            .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                    })
                }
            VStack {
            
                HStack {
                    Text("編輯")
                        .foregroundColor(Color(red: 105/255, green: 120/255, blue: 85/255))
                        .font(.system(size: 36, weight: .medium))
                    Spacer()
                }
                ZStack {
                    Image("\(avatar)_彩色")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 66, height: 66)
                        .frame(width: 120, height: 120)
                        .background(Color(red: COLORS[avatarColor][0]/255, green: COLORS[avatarColor][1]/255, blue: COLORS[avatarColor][2]/255))
                        .clipShape(Circle())
                    Button(action: {
                        openAvatar.toggle()
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .resizable().scaledToFit().frame(width: 30)
                            .foregroundColor(Color(red: 105/255, green: 120/255, blue: 85/255))
                    }.offset(x: 50, y: 40)
                        .sheet(isPresented: $openAvatar) {
                            AvatarView(show: $openAvatar, avatar: $avatar, avatarColor: $avatarColor
                            )
                        }
                }.padding(.bottom, 40)
                ZStack(alignment: .leading) {
                    if username.isEmpty {
                        Text("使用者暱稱")
                            .padding(.top, 30)
                            .foregroundColor(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("名稱")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        TextField("", text: $username)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        Divider().overlay(Color(red: 100/255, green: 114/255, blue: 93/255))
                    }
                }
                ZStack(alignment: .leading) {
                    if email.isEmpty {
                        Text("example@mail.com")
                            .padding(.top, 30)
                            .tint(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("帳號")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        TextField("", text: $email)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        Divider().overlay(Color(red: 100/255, green: 114/255, blue: 93/255))
                    }
                }.padding(.top, 20)
                    .padding(.bottom, 20)
                
                Button(action: {
                    viewModel.update(withEmail: email, username: username, avatar: avatar, avatarColor: avatarColor)
                    mode.wrappedValue.dismiss()
                }, label: {
                    Text("儲存編輯")
                        .font(.headline)
                        .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                        .frame(width: 314, height: 48)
                        .background(Color(red: 176/255, green: 184/255, blue: 153/255))
                        .cornerRadius(9)
                        .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                })
                Spacer()
            }.padding(.top, 90)
                .padding(.horizontal, 40)
        }
    }
}

//struct EditUserView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditUserView()
//    }
//}
