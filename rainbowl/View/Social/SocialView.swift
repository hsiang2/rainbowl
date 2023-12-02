//
//  SocialView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct SocialView: View {
     @Binding var show: Bool

    @State var searchText = ""
    @State var inSearchMode = false
    @StateObject var viewModel = SearchUserViewModel()

    var body: some View {
        NavigationView {
            
            ZStack {
                Color(red: 225/255, green: 232/255, blue: 234/255)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            show = false
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding()
                                .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255)).padding()
                            
                        }
                    }
                ScrollView {
                    SearchBar(text: $searchText, isEditing: $inSearchMode)
                        .padding()
                    
                    //                        ZStack {
                    //                            if inSearchMode {
                    
                    UserListView(viewModel: viewModel, searchText: $searchText)
                    
                    
                    //                            } else {
                    //                                PostGridView(config: .explore)
                    //                            }
                    //                        }
                }.padding(.top, 70)
            }
        }
    }
}

struct SocialView_Previews: PreviewProvider {
    static var previews: some View {
        SocialView(show: .constant(true))
    }
}
