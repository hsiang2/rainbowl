//
//  CalendarView.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/5/6.
//

import SwiftUI

struct CalendarView: View {
    @State private var recordDate = Date()
     @Binding var show: Bool
     @StateObject var recordViewModel: FetchRecordViewModel

    init(show: Binding<Bool>) {
           self._show = show
        _recordViewModel = StateObject(wrappedValue: FetchRecordViewModel(date: Date()))
       }
//    @State private var recordDate = Date()
//    @Binding var show: Bool
//
//    @StateObject var recordViewModel: FetchRecordViewModel = FetchRecordViewModel(date: Date())
//
//    init(show: Binding<Bool>) {
//     
//        self._show = show
//        let viewModel = FetchRecordViewModel(date: recordDate)
//        _recordViewModel = StateObject(wrappedValue: viewModel)
//    }
//    
    var body: some View {
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
            VStack {
                DatePicker("Date", selection: $recordDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "zh_Hant_TW"))
//                   .environment(\.calendar, Calendar(identifier: .republicOfChina))
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .tint(Color(red: 49/255, green: 122/255, blue: 144/255))
                        .background(Color(red: 239/255, green: 241/255, blue: 243/255))
                        .frame(width: 330)
                        .cornerRadius(25)
                        .onChange(of: recordDate) { newDate in
                                        recordViewModel.fetchRecords(date: newDate)
                        }
                if( recordViewModel.records.isEmpty ) {
                    Color(red: 225/255, green: 232/255, blue: 234/255)
                        .ignoresSafeArea()
                } else {
                    List {
                        ForEach(recordViewModel.records) { record in
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
                                
                        }.listRowBackground(Color(white: 0, opacity: 0))
                            .background(Color.clear)
                    }.listStyle(.plain)
                        .padding(.vertical, 20)
                    
                }
            }.padding(.top, 70)
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView(show: .constant(true))
//    }
//}
