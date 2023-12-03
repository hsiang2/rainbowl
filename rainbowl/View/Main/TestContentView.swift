//
//  TestContentView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/2.
//

import SwiftUI

struct TestContentView: View {
    var body: some View {
        MyViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}

struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestContentView()
    }
}

struct MyViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MyViewController {
        return MyViewController()
    }

    func updateUIViewController(_ uiViewController: MyViewController, context: Context) {
        // 更新視圖控制器
    }
}

//#Preview {
//    TestContentView()
//}
