//
//  UIApplication+Extensions.swift
//  Drill
//
//  Created by Filipi Romão on 02/06/25.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
