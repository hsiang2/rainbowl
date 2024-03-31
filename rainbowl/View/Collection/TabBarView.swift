//
//  TabBarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct TabBarView: View {
    @Binding var currentTab: Int
        @Namespace var namespace
        
        var tabBarOptions: [String] = ["動物", "植物"]
        var body: some View {
//            ScrollView(.horizontal, showsIndicators: false) {
                HStack(
                    spacing: 0
                ) {
                    ForEach(Array(zip(self.tabBarOptions.indices,
                                      self.tabBarOptions)),
                            id: \.0,
                            content: {
                        index, name in
                        TabBarItem(currentTab: self.$currentTab,
                                   namespace: namespace.self,
                                   tabBarItemName: name,
                                   tab: index)
                        
                    })
                }
                .padding(.horizontal, 60)
                .frame(height: 80)
//            }
//            .background(Color.white)
//            .frame(height: 80)
//            .edgesIgnoringSafeArea(.all)
        }
}

struct TabBarItem: View {
    @Binding var currentTab: Int
    let namespace: Namespace.ID
    
    var tabBarItemName: String
    var tab: Int
    
    var body: some View {
        Button {
            self.currentTab = tab
            SoundPlayer.shared.playClickSound()
        } label: {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(tabBarItemName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
              
//                    Text(tabBarItemName)
                    Spacer()
                }
                
                ZStack {
                    Color(red: 142/255, green: 135/255, blue: 129/255).frame(height: 5)
                    if currentTab == tab {
                        Color(red: 217/255, green: 187/255, blue: 137/255)
                            .frame(height: 5)
                            .matchedGeometryEffect(id: "underline",
                                                   in: namespace,
                                                   properties: .frame)

                    } else {
                        Color.clear.frame(height: 5)
                    }
                }
                
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)

    }
}

//struct TabBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabBarView()
//    }
//}
