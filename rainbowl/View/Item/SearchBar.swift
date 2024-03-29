//
//  SearchBarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @State private var animate = false
    
    var body: some View {
        HStack {
            TextField("搜尋", text: $text)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color(red: 60/255, green: 60/255, blue: 67/255).opacity(0.6))
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(red: 118/255, green: 118/255, blue: 128/255).opacity(0.12))
                .cornerRadius(10)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                )
                .padding(.horizontal, 24)
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button(action: {
                    animate = false
                    isEditing = false
                    text = ""
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("取消")
                        .foregroundColor(Color(red: 167/255, green: 176/255, blue: 184/255))
                })
                .padding(.trailing, 8)
                .transition(.move(edge: .trailing))
                .animation(.default, value: animate)
                .onAppear { animate = true }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search..."), isEditing: .constant(true))
    }
}
