//
//  Extensions.swift
//  rainbowl
//
//  Created by 蔡相襄 on 2023/12/1.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

