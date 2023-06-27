//
//  ItemsView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct ItemsView: View {
    private let items = [GridItem(), GridItem(), GridItem()]
    private let width = UIScreen.main.bounds.width / 3
    
    let tests = ["黑白鹿", "彩色鹿", "虎鯨_黑白", "樹_黑白"]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: items, spacing: 2, content: {
                ForEach(tests, id: \.self) { test in
                    ZStack {
                        Image("box_bg")
                        Image(test)
                           .resizable().scaledToFit().frame(width: 70, height: 70)
                    }.frame(width: width, height: width)
                   
                }
            }).padding()
                .padding(.top, 90)
            Spacer()
        }
        
        
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
    }
}
