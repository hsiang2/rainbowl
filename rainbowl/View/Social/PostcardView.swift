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
    
    var body: some View {
//        ZStack {
//            Color(red: 230/255, green: 229/255, blue: 222/255)
//                .ignoresSafeArea()
                VStack(alignment: .leading) {
                    
                    
                    Text("禮物")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                    if !creatureName.isEmpty {
                                   ZStack {
                                       Image("\(creatureName)_彩色")
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 70, height: 70)
                                           .saturation(0)
                                   }
                               }
                    Text("留言")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                    Text(message)
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 139/255, green: 128/255, blue: 101/255))
                }
        }
//    }
}

//#Preview {
//    PostcardView()
//}
