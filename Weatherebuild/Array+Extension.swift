//
//  Array+Extension.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 26.11.2022.
//

import SwiftUI

extension Array where Element == Gradient.Stop {
    func interpolated(amount: Double) -> Color {
        self[0].color
    }
}
