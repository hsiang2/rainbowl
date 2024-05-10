//
//  SearchBarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
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
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant("Search..."))
    }
}
