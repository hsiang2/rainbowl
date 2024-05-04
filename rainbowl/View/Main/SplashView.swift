//
//  SplashView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2024/5/3.
//

import SwiftUI

@available(iOS 17.0, *)
struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
                   if self.isActive {
                       ContentView()
                   } else {
                       ZStack {
                           Color(red: 244/255, green: 242/255, blue: 236/255)
                               .ignoresSafeArea()
                           Image("splash_logo")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 93)
                       }
                   }
               }
               .onAppear {
                   DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                       withAnimation {
                           self.isActive = true
                       }
                   }
               }
       
        
    }
}

//#Preview {
//    SplashView()
//}
