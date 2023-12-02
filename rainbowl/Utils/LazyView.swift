//
//  LazyView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping() -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
