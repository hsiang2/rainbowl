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
            VStack {
                VStack(spacing: 20) {
//                    CustomTextField(text: $email, placeholder: Text("信箱"), imageName: "envelope")
//                        .padding()
//                        .background(Color(.init(white: 1, alpha: 0.15)))
//                        .cornerRadius(10)
//                        .foregroundColor(.white)
//                        .padding(.horizontal, 32)
                }
                
                Button(action: {
                    viewModel.resetPassword(withEmail: email)
                }, label: {
                    Text("傳送重設密碼連結")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 50)
                        .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
                        .clipShape(Capsule())
                        .padding()
                })
                
                Spacer()
                
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Text("已經有帳號了嗎？")
                            .font(.system(size: 14))
                        Text("登入")
                            .font(.system(size: 14, weight: .semibold))
                    }
//                    .foregroundColor(.white)
                })
            }
            .padding(.top, -44)
        }
//        .onReceive(, perform: <#T##(Publisher.Output) -> Void#>)
    }
}

//struct ResetPasswordView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResetPasswordView(email: <#T##Binding<String>#>)
//    }
//}
