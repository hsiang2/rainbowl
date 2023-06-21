//
//  ColorListView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI

struct ColorListView: View {
    var colors = ["紅", "橙", "黃", "綠", "紫", "白"]
    @Binding var selectedIndex: String
//    @State private var selectedBtn: Int = 0
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedIndex = color
                    }) {
                        ZStack {
                            
                            Image("color_focus")
                                .padding(.top, 60)
                                .opacity(selectedIndex == color ? 1 : 0)
                            Image(color)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65)
                                
                        }.padding(.leading, 20)
                        
                    }
                }
            }
        }
//        VStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 40) {
//                    Button(action: {
//                        selectedBtn = 0
//                    }) {
//                        Image("紅色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                    Button(action: {
//                        selectedBtn = 1
//                    }) {
//                        Image("橘色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                    Button(action: {
//                        selectedBtn = 2
//                    }) {
//                        Image("黃色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                    Button(action: {
//                        selectedBtn = 3
//                    }) {
//                        Image("綠色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                    Button(action: {
//                        selectedBtn = 4
//                    }) {
//                        Image("紫色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                    Button(action: {
//                        selectedBtn = 5
//                    }) {
//                        Image("白色")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 65)
//                    }
//                }.padding()
//            }
//            ColorContentView(selectedIndex: $selectedBtn)
    }
}

//struct ColorListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorListView(selectedIndex: <#T##Binding<String>#>)
//    }
//}
