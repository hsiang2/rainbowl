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
    @State var inSearchMode = false
    @ObservedObject var socialViewModel: SocialViewModel
    @ObservedObject var backpackViewModel: BackpackViewModel
    
    @State var currentTab: Int = 0

    var body: some View {
        NavigationView {
            
            
            ZStack {
                Color(red: 233/255, green: 230/255, blue: 221/255)
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
                
                            SearchBar(text: $searchText, isEditing: $inSearchMode)
                               .padding()
                            FriendListView(socialViewModel: socialViewModel, backpackViewModel: backpackViewModel, searchText: $searchText)
                          }.tag(0)
                        ScrollView {
                
                              SearchBar(text: $searchText, isEditing: $inSearchMode)
                                  .padding()
                
                            UserListView(socialViewModel: socialViewModel, searchText: $searchText)
                          }.tag(1)
                        
                    }.padding(.top, 200)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .edgesIgnoringSafeArea(.all)
                    SocialTabBarView(currentTab: self.$currentTab).padding(.top, 40)
//                    Color(red: 230/255, green: 229/255, blue: 222/255)
//                        .ignoresSafeArea()
//                        .frame(height: 100)
//                        .overlay(alignment: .topTrailing) {
//                           
//                        }
                }
                
            }
                
               
                
//                VStack {
//                    HStack {
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Text("好友")
////                            Image("背包")
////                                .resizable()
////                                .scaledToFit()
////                                .frame(width: 42, height: 42)
////                                .padding()
//                            Spacer()
//                        }
//                        .background(selectedTab == .FirstTab ? Color(red: 230/255, green: 229/255, blue: 222/255) : Color(red: 209/255, green: 206/255, blue: 194/255))
//                        .onTapGesture {
//                            self.selectedTab = .FirstTab
//                        }
//                        Spacer()
//                        HStack {
//                            Spacer()
//                            Text("探索")
////                            Image("圖鑑")
////                                .resizable()
////                                .scaledToFit()
////                                .frame(width: 42, height: 42)
////                                .padding()
//                            Spacer()
//                        }.background(selectedTab == .SecondTab ? Color(red: 230/255, green: 229/255, blue: 222/255) : Color(red: 209/255, green: 206/255, blue: 194/255))
//                        .onTapGesture {
//                            self.selectedTab = .SecondTab
//                        }
//                        Spacer()
//
//                    }
//    //                .padding(.bottom)
//    //                .background(Color.green.edgesIgnoringSafeArea(.all))
//                    
//                    Spacer()
//                    
//                    if selectedTab == .FirstTab {
//                        ScrollView {
//                            
//                            SearchBar(text: $searchText, isEditing: $inSearchMode)
//                                .padding()
//                            FriendListView(viewModel: viewModel, searchText: $searchText)
//                        }
//                    } else if selectedTab == .SecondTab {
//                        ScrollView {
//                            
//                            SearchBar(text: $searchText, isEditing: $inSearchMode)
//                                .padding()
//                            UserListView(viewModel: viewModel, searchText: $searchText)
//                        }
//                    }
//                }.padding(.top, 70)
//            }
        }
    }
}

//@available(iOS 17.0, *)
//struct FriendView: View {
//    @State var searchText = ""
//    @State var inSearchMode = false
//    @StateObject var viewModel = SocialViewModel()
//    var body: some View {
//        ScrollView {
//
//           SearchBar(text: $searchText, isEditing: $inSearchMode)
//               .padding()
//           FriendListView(viewModel: viewModel, searchText: $searchText)
//       }
//    }
//}
//
//@available(iOS 17.0, *)
//struct ExploreView: View {
//    @State var searchText = ""
//    @State var inSearchMode = false
//    @StateObject var viewModel = SocialViewModel()
//    var body: some View {
//        ScrollView {
//
//              SearchBar(text: $searchText, isEditing: $inSearchMode)
//                  .padding()
//  
//                UserListView(viewModel: viewModel, searchText: $searchText)
//          }
//    }
//}

//@available(iOS 17.0, *)
//struct SocialView_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialView(show: .constant(true))
//    }
//}
