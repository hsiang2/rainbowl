//
//  CustomSecureField.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/3.
//

import SwiftUI

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: Text
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 40)
//                    .foregroundColor(<#T##color: Color?##Color?#>)
            }
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
//                    .foregroundColor(<#T##color: Color?##Color?#>)
                SecureField("", text: $text)
            }
        }
    }
}

struct CustomSecureField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureField(text: .constant(""), placeholder: Text("Email"))
    }
}
