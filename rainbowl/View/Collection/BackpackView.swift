//
//  BackpackView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/27.
//

import SwiftUI

struct BackpackView: View {
//    @State var currentTab: Int = 0
//    var selectedCategory: String = ""
//    
//    @Binding var creature: Creature?
//    @Binding var show: Bool?
//    
//    init(currentTab: Int, selectedCategory: String, creature: Binding<Creature?>, show: Binding<Bool?>) {
//           self.currentTab = currentTab
//           self.selectedCategory = selectedCategory
//           self._creature = creature
//           self._show = show
//       }
    
    @ObservedObject var backpackViewModel: BackpackViewModel
    @State private var currentTab: Int
        private var selectedCategory: String
    
        private var mode: String
        @Binding var targetCreature: Creature?
        @Binding var show: Bool?

    init(backpackViewModel: BackpackViewModel, currentTab: Int = 0, selectedCategory: String = "", mode: String, targetCreature: Binding<Creature?>?, show: Binding<Bool?>?) {
        self.backpackViewModel = backpackViewModel
            self._currentTab = State(initialValue: currentTab)
            self.selectedCategory = selectedCategory
            self.mode = mode
            self._targetCreature = targetCreature ?? .constant(nil)
            self._show = show ?? .constant(nil)
        }

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: self.$currentTab) {
                ItemsView(selectedCategory: "動物", backpackViewModel: backpackViewModel, mode: mode, targetCreature: $targetCreature, show: $show).tag(0)
                ItemsView(selectedCategory: "植物", backpackViewModel: backpackViewModel, mode: mode, targetCreature: $targetCreature, show: $show).tag(1)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)
            
            Color(red: 230/255, green: 229/255, blue: 222/255)
                .ignoresSafeArea()
                .frame(height: 100)
                .overlay(alignment: .topTrailing) {
                    TabBarView(currentTab: self.$currentTab)
                }
        }
    }
}

//struct BackpackView_Previews: PreviewProvider {
//    static var previews: some View {
//        BackpackView()
//    }
//}
