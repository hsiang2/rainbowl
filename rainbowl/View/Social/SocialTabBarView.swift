//
//  SocialTabBarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/3/16.
//

import SwiftUI

struct SocialTabBarView: View {
    @Binding var currentTab: Int
        @Namespace var namespace
        
        var tabBarOptions: [String] = ["好友", "探索"]
        var body: some View {
                HStack(
                    spacing: 0
                ) {
                    ForEach(Array(zip(self.tabBarOptions.indices,
                                      self.tabBarOptions)),
                            id: \.0,
                            content: {
                        index, name in
                        SocialTabBarItem(currentTab: self.$currentTab,
                                   namespace: namespace.self,
                                   tabBarItemName: name,
                                   tab: index)
                        
                    })
                }
                .padding(.horizontal, 139)
                .frame(height: 80)
        }
}

struct SocialTabBarItem: View {
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
                    Text(tabBarItemName)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(red: 59/255, green: 48/255, blue: 41/255))
                        .opacity(currentTab == tab ? 1 : 0.35)
                    Spacer()
                }
                
                ZStack {
//                    Color(red: 142/255, green: 135/255, blue: 129/255).frame(height: 5)       .cornerRadius(50)
                    if currentTab == tab {
                        Color(red: 217/255, green: 187/255, blue: 137/255)
                            .frame(width: 24, height: 5)
                            .cornerRadius(50)
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
