//
//  DateChangeViewModel.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/6/25.
//

import SwiftUI
import Combine

class DateChangeViewModel: ObservableObject {
    @Published var currentDate = Date()
    
    @Published var previousDate = Date()
    private var cancellables = Set<AnyCancellable>()
        
        private var timer: Timer?
        
        init() {
            startTimer()
            
            $currentDate
                        .receive(on: DispatchQueue.main)
                        .sink { [weak self] date in
                            if !Calendar.current.isDate(self?.previousDate ?? Date(), inSameDayAs: date) {
                                DispatchQueue.main.async {
                                    self?.handleDateChange()
                                    self?.previousDate = date
                                }
                            }
                        }
                        .store(in: &cancellables)
            
        }
        
        private func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                DispatchQueue.main.async {
                    self?.currentDate = Date()
                }
            }
        }
        
        func handleDateChange() {
            // Perform any actions you need when the date changes
            print("Date changed!")
            AuthViewModel.shared.updateColors()
        }
}
