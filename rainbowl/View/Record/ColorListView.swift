//
//  ColorListView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/4/29.
//

import SwiftUI

struct ColorListView: View {
    let user: User
    var colors: [String]
    @Binding var selectedIndex: String
    var opacity: [Float] = [0, 0, 0, 0, 0, 0]
    
    
    init(user: User, selectedIndex: Binding<String>) {
        self._selectedIndex = selectedIndex
        self.user = user
        self.colors = ["紅", "橙", "黃", "綠", "紫", "白"]
        
        self.opacity[0] = user.red?.reduce(0) { $0 + $1 } ?? 0
        self.opacity[1] = user.orange?.reduce(0) { $0 + $1 } ?? 0
        self.opacity[2] = user.yellow?.reduce(0) { $0 + $1 } ?? 0
        self.opacity[3] = user.green?.reduce(0) { $0 + $1 } ?? 0
        self.opacity[4] = user.purple?.reduce(0) { $0 + $1 } ?? 0
        self.opacity[5] = user.white?.reduce(0) { $0 + $1 } ?? 0
//        print(opacity)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors.indices, id: \.self) { index in
                    
                    
                    Button(action: {
                        selectedIndex = colors[index]
                    }) {
                        ZStack {
                            
                            Image("color_focus")
                                .padding(.top, 60)
                                .opacity(selectedIndex == colors[index] ? 1 : 0)
                            
                            Image(colors[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 65)
                            Image("\(colors[index])_滿")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50)
                                .padding(.top, 15)
//                                .blendMode(.darken)
                                .mask( Rectangle().frame(width: 50).padding(.top, 55 - CGFloat((40 * opacity[index] )))
                                    
                                )
                           
//                            Image("\(color)_滿")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 65)
          
//                            Image(color)
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 65)
                                
                            
                                
                        }.padding(.leading, 20)
                        
                    }
                }
            }
        }
    }
}

//struct ColorListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorListView()
//    }
//}
