//
//  bookView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct BookView: View {
    @State var currentTab: Int = 0
    var selectedCategory: String = ""
    
    var body: some View {
        ZStack(alignment: .top) { 
                    TabView(selection: self.$currentTab) {
                        
                        BookItemsView(selectedCategory: "動物").tag(0)
                        BookItemsView(selectedCategory: "植物").tag(1)

                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    
                    TabBarView(currentTab: self.$currentTab)
                
        }
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
