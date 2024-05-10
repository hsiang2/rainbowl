//
//  PostcardView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/22.
//

import SwiftUI

struct PostcardView: View {
    let creatureName: String
    let message: String
    let receiver: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("卡片")
                 .resizable().scaledToFit().frame(width: 354, height: 529)
            VStack {
                ZStack {
                   Image("卡片_內層")
                        .resizable().scaledToFit().frame(width: 316, height: 353)
                    VStack(alignment: .leading) {
                        if !creatureName.isEmpty {
                           Image("\(creatureName)_彩色")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 193, height: 193)
                               .saturation(0)

                        }
                    }
                }.padding(.vertical, 32)
                Text("To: \(receiver)")
                    .font(.system(size: 18, design: .serif))
                    .foregroundStyle(LinearGradient(
                        stops: [.init(color: Color(red: 57/255, green: 57/255, blue: 57/255), location: 0.42), .init(color: Color(red: 155/255, green: 155/255, blue: 155/255), location: 0.74), .init(color:  Color(red: 83/255, green: 83/255, blue: 83/255), location: 1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .padding(.bottom, 10)
                Text(message)
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 108/255, green: 108/255, blue: 108/255))
                    .frame(width: 314)
            }
        }
        
    }
}

//#Preview {
//    PostcardView()
//}
