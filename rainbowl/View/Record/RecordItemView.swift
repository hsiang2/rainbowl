//
//  RecordItemView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/21.
//

import SwiftUI

struct RecordItemView: View {
    
    @Binding var selectedIndex: String
   
    @ObservedObject var viewModel = RecordViewModel()
//    @ObservedObject var viewModel = FetchRecordViewModel()

    
//    @State private var allRecord = [Record]()
//
//    var records: [Record] {
//        if selectedIndex == "" {
//            return allRecord
//        }
//
//        return allRecord.filter({
//            $0.color.contains(selectedIndex)
//        })
//    }
    
    var records: [Record] {
        return selectedIndex == "" ? viewModel.records : viewModel.records.filter({
            $0.color.contains(selectedIndex)
        })
    }
    
    var body: some View {
        //        ScrollView(showsIndicators: false) {
        if( records.isEmpty ) {
            Color(red: 245/255, green: 245/255, blue: 245/255)
                .ignoresSafeArea()
        } else {
            List {
                ForEach(records) { record in
                    HStack {
                        Image(record.name).resizable().scaledToFit().frame(width: 45, height: 45)
                        VStack(alignment: .leading) {
                            Text(record.name)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(Color(red: 59/255, green: 65/255, blue: 60/255)).padding(.bottom, 1)
                            Text("熱量 : \(String(format: "%g", record.calorie))kcal")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 146/255, green: 154/255, blue: 140/255))
                        }.padding(.leading, 5)
                        Spacer()
                        Text(String(format: "%g", record.qty))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(red: 73/255, green: 80/255, blue: 87/255))
                        Text("份")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(Color(red: 37/255, green: 53/255, blue: 52/255))
                            .opacity(0.7)
                        
                    }.padding(.horizontal, 40)
                        .listRowSeparator(.hidden)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                viewModel.deleteRecord(id: record.id ?? "", color: record.color, records: records)
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15)
                            }
                            .tint(Color(red: 228/255, green: 126/255, blue: 83/255))
                            
                            //                        Button(role: .destructive) {
                            //
                            //                        } label: {
                            //                            Image(systemName: "pencil")
                            //                                .resizable()
                            //                                .scaledToFit()
                            //                                .frame(width: 13)
                            //                        }.tint(Color(red: 161/255, green: 197/255, blue: 124/255))
                            
                        }
                }.listRowBackground(Color(white: 0, opacity: 0))
                    .background(Color.clear)
            }.listStyle(.plain)
                .padding(.vertical, 20)
        }
    }
//    func delete(at offsets: IndexSet) {
//        viewModel.records.remove(atOffsets: offsets)
//    }
}




struct RecordItemView_Previews: PreviewProvider {
    static var previews: some View {
        RecordItemView(selectedIndex: .constant("黃"))
    }
}
