//
//  BackpackView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct BackpackView: View {
    @State var currentTab: Int = 0
    var selectedCategory: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                ItemsView(selectedCategory: "動物").tag(0)
                ItemsView(selectedCategory: "植物").tag(1)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            Color(red: 230/255, green: 229/255, blue: 222/255)
                .ignoresSafeArea()
                .frame(height: 100)
                .overlay(alignment: .topTrailing) {
                    TabBarView(currentTab: self.$currentTab)
                }
        }
    }
}

struct BackpackView_Previews: PreviewProvider {
    static var previews: some View {
        BackpackView()
    }
}
