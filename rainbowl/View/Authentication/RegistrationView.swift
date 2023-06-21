//
//  RegistrationView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/3.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        ZStack {
            Color(red: 241/255, green: 240/255, blue: 234/255)
                .ignoresSafeArea()
            VStack {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Spacer()
                        Text("登入")
                            .font(.system(size: 18, weight: .semibold))
                    }
                        .foregroundColor(Color(red: 215/255, green: 169/255, blue: 52/255))
                }).padding(.bottom, 75)
                HStack {
                    Text("註冊")
                        .foregroundColor(Color(red: 105/255, green: 120/255, blue: 85/255))
                        .font(.system(size: 36, weight: .medium))
                    Spacer()
                }
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
                }.padding(.top, 42)
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
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("6-12位數字與英文組合")
                            .padding(.top, 30)
                            .foregroundColor(Color(red: 158/255, green: 155/255, blue: 145/255)).opacity(0.62)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("密碼")
                            .font(.system(size: 18))
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        SecureField("", text: $password)
                            .textInputAutocapitalization(.never)
                            .foregroundColor(Color(red: 101/255, green: 113/255, blue: 85/255))
                        Divider().overlay(Color(red: 100/255, green: 114/255, blue: 93/255))
                    }
                }.padding(.top, 20)

                Button(action: {
                    viewModel.register(withEmail: email, password: password, username: username)
                }, label: {
                    Text("建立帳號")
                        .font(.headline)
                        .foregroundColor(Color(red: 241/255, green: 239/255, blue: 234/255))
                        .frame(width: 314, height: 48)
                        .background(Color(red: 176/255, green: 184/255, blue: 153/255))
                        .cornerRadius(9)
                        .shadow(color: Color(red: 216/255, green: 214/255, blue: 209/255), radius: 6, x: 0, y: 4)
                        .padding(.top, 20)
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
//        ZStack {
//
//            VStack {
//                VStack(spacing: 20) {
//                    CustomTextField(text: $email, placeholder: Text("信箱"), imageName: "envelope")
//                        .padding()
////                        .background(Color(.init(white: 1, alpha: 0.15)))
////                        .cornerRadius(10)
////                        .foregroundColor(.white)
//                        .padding(.horizontal, 32)
//                    CustomTextField(text: $username, placeholder: Text("使用者名稱"), imageName: "person")
//                        .padding()
////                        .background(Color(.init(white: 1, alpha: 0.15)))
////                        .cornerRadius(10)
////                        .foregroundColor(.white)
//                        .padding(.horizontal, 32)
//                    CustomSecureField(text: $password, placeholder: Text("密碼"))
//                        .padding()
////                        .background(Color(.init(white: 1, alpha: 0.15)))
////                        .cornerRadius(10)
////                        .foregroundColor(.white)
//                        .padding(.horizontal, 32)
//                }
//                Button(action: {
//                    viewModel.register(withEmail: email, password: password, username: username)
//                }, label: {
//                    Text("註冊")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .frame(width: 360, height: 50)
//                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
//                        .clipShape(Capsule())
//                        .padding()
//                })
//
//                Spacer()
//
//                Button(action: {
//                    mode.wrappedValue.dismiss()
//                }, label: {
//                    HStack {
//                        Text("已經有帳號了嗎？")
//                            .font(.system(size: 14))
//                        Text("登入")
//                            .font(.system(size: 14, weight: .semibold))
//                    }
////                    .foregroundColor(.white)
//                })
//            }
//        }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
