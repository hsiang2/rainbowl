//
//  CustomTextFieldView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/3.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    let placeholder: Text
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 40)
//                    .foregroundColor(<#T##color: Color?##Color?#>)
            }
            
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                //                    .foregroundColor(<#T##color: Color?##Color?#>)
                TextField("", text: $text)
                    .textInputAutocapitalization(.never)
                
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant(""), placeholder: Text("Email"), imageName: "envelope")
    }
}
