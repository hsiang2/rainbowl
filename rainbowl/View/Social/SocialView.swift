//
//  SocialView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

@available(iOS 17.0, *)
struct SocialView: View {
     @Binding var show: Bool

    @State var searchText = ""
    @ObservedObject var socialViewModel: SocialViewModel
    @ObservedObject var backpackViewModel: BackpackViewModel
    
    @State var currentTab: Int = 0

    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color(red: 241/255, green: 231/255, blue: 224/255)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            show = false
                            SoundPlayer.shared.playCloseSound()
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                            
                        }
                    }
                
                ZStack(alignment: .top) {
                    TabView(selection: self.$currentTab) {
                        ScrollView {
                            SearchBar(text: $searchText)
                               .padding()
                            FriendListView(socialViewModel: socialViewModel, backpackViewModel: backpackViewModel, searchText: $searchText)
                          }.tag(0)
                        ScrollView {
                
                              SearchBar(text: $searchText)
                                  .padding()
                
                            UserListView(socialViewModel: socialViewModel, searchText: $searchText)
                          }.tag(1)
                        
                    }.padding(.top, 200)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    SocialTabBarView(currentTab: self.$currentTab).padding(.top, 40)
                }
                
            }
        }
    }
}

//@available(iOS 17.0, *)
//struct SocialView_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialView(show: .constant(true))
//    }
//}
