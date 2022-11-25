//
//  Color+Extension.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 26.11.2022.
//

import SwiftUI

/// Extension containing all background color that used in UI composition
extension Color {
  static let midnightStart = Color(hue: 0.66, saturation: 0.8, brightness: 0.1)
  static let midnightEnd = Color(hue: 0.62, saturation: 0.5, brightness: 0.33)
  static let sunriseStart = Color(hue: 0.62, saturation: 0.6, brightness: 0.42)
  static let sunriseEnd = Color(hue: 0.95, saturation: 0.35, brightness: 0.66)
  static let sunnyDayStart = Color(hue: 0.6, saturation: 0.6, brightness: 0.6)
  static let sunnyDayEnd = Color(hue: 0.6, saturation: 0.4, brightness: 0.85)
  static let sunsetStart = Color.sunriseStart
  static let sunsetEnd = Color(hue: 0.05, saturation: 0.34, brightness: 0.65)
}

/// Extension for two methods: one for returning tuple with color components, other for interpolate that color components
extension Color {
  /// retrieved the RGBA values for a given Color
  func getComponents() -> (red: Double, green: Double, blue: Double, alpha: Double) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    var alpha: CGFloat = 0

    let uiColor = UIColor(self)
    uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    return (red, green, blue, alpha)
  }

  /// knows how to blend any one Color with another Color based on some amount value
  func interpolated(to other: Color, amount: Double) -> Color {
    let componentsFrom = self.getComponents()
    let componentsTo = other.getComponents()

    let newRed = (1.0 - amount) * componentsFrom.red + (amount * componentsTo.red)
    let newGreen = (1.0 - amount) * componentsFrom.green + (amount * componentsTo.green)
    let newBlue = (1.0 - amount) * componentsFrom.blue + (amount * componentsTo.blue)
    let newOpacity = (1.0 - amount) * componentsFrom.alpha + (amount * componentsTo.alpha)

    return Color(.displayP3, red: newRed, green: newGreen, blue: newBlue, opacity: newOpacity)
  }
}