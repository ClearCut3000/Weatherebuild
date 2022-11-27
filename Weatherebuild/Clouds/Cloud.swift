//
//  Cloud.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 24.11.2022.
//

import SwiftUI

class Cloud {

  //MARK: - Properties
  enum Thickness: CaseIterable {
    case none, thin, light, regular, thick, ultra
  }
  var position: CGPoint
  var imageNumber: Int
  let speed = Double.random(in: 4...12)
  let scale: Double

  //MARK: - Init
  init(imageNumber: Int, scale: Double) {
    self.imageNumber = imageNumber
    self.scale = scale

    let startX = Double.random(in: -400...400)
    let startY = Double.random(in: -50...200)
    position = CGPoint(x: startX, y: startY)
  }
}
