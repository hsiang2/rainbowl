//
//  SettingView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/24.
//

import SwiftUI

struct SettingView: View {
    @Binding var show: Bool
    var body: some View {
        ZStack {
            Color(red: 225/255, green: 232/255, blue: 234/255)
                .ignoresSafeArea()
                .overlay(alignment: .topTrailing) {
                    Button {
                        show = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding()
                            .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                            
                    }
                }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(show: .constant(true))
    }
}
