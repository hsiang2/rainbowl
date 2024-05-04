//
//  ResetPasswordView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/4.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var mode
    @Binding private var email: String
    
    init(email: Binding<String>) {
        self._email = email
    }
    
    var body: some View {
        ZStack {
            Color(red: 241/255, green: 239/255, blue: 234/255)
                .ignoresSafeArea()
            VStack {
                
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("返回")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(Color(red: 215/255, green: 169/255, blue: 52/255))
                    
                }).padding(.bottom, 75)
                HStack {
                    Text("忘記密碼")
                        .foregroundColor(Color(red: 129/255, green: 117/255, blue: 87/255))
                        .font(.system(size: 36, weight: .medium))
                    Spacer()
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
                            .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                        TextField("", text: $email)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(Color(red: 171/255, green: 147/255, blue: 84/255))
                        Divider().overlay(Color(red: 139/255, green: 128/255, blue: 101/255))
                    }
                }.padding(.top, 42)
                
                
                
                Button(action: {
                    viewModel.resetPassword(withEmail: email)
                }, label: {
                    Text("傳送重設密碼連結")
                        .font(.headline)
                        .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                        .frame(width: 314, height: 48)
                        .background(Color(red: 184/255, green: 175/255, blue: 153/255))
                        .cornerRadius(9)
                        .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                        .padding(.top, 70)
                })
                Spacer()
                HStack(spacing: 38) {
                    Spacer()
                    Image("送子鳥")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                    Image("註冊鹿")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 95)
                }
            }.padding(.top, 10)
                .padding(.horizontal, 40)
        }
    }
}

//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView(email: <#T##Binding<String>#>)
//    }
//}
