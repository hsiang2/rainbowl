//
//  BackpackView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct BackpackView: View {
    @State var currentTab: Int = 0

    var body: some View {
        ZStack(alignment: .top) {
                    TabView(selection: self.$currentTab) {
                        ItemsView().tag(0)
                        ItemsView().tag(1)
//                        ItemsView().tag(2)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    
                    TabBarView(currentTab: self.$currentTab)
                }
    }
}

struct BackpackView_Previews: PreviewProvider {
    static var previews: some View {
        BackpackView()
    }
}
