//
//  CollectionView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

@available(iOS 16.4, *)
struct CollectionView: View {
    @Binding var show: Bool
    @ObservedObject var backpackViewModel: BackpackViewModel

    @State var selectedTab = Tabs.FirstTab
    var body: some View {
        ZStack {
            Color(red: 230/255, green: 229/255, blue: 222/255)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image("背包")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                            .padding()
                        Spacer()
                    }
                    .background(selectedTab == .FirstTab ? Color(red: 230/255, green: 229/255, blue: 222/255) : Color(red: 209/255, green: 206/255, blue: 194/255))
                    .onTapGesture {
                        self.selectedTab = .FirstTab
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        Image("圖鑑")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 42, height: 42)
                            .padding()
                        Spacer()
                    }.background(selectedTab == .SecondTab ? Color(red: 230/255, green: 229/255, blue: 222/255) : Color(red: 209/255, green: 206/255, blue: 194/255))
                    .onTapGesture {
                        self.selectedTab = .SecondTab
                    }
                    Spacer()

                }
                
                Spacer()
                
                if selectedTab == .FirstTab {
                    BackpackView(backpackViewModel: backpackViewModel, mode: "backpack", targetCreature: nil, show: Binding<Bool?>(get: { self.show }, set: { self.show = $0 ?? false }))
                } else if selectedTab == .SecondTab {
                    BookView()
                }
            }
        }.presentationDetents([.fraction(0.8)])
            .presentationCornerRadius(30)
    }
}

enum Tabs {
    case FirstTab
    case SecondTab
}

//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView(show: .constant(true))
//    }
//}
