//
//  CollectionView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

struct CollectionView: View {
    @Binding var show: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(show: .constant(true))
    }
}
