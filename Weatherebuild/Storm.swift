//
//  Storm.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 29.11.2022.
//

import SwiftUI

class Storm {
    enum Contents: CaseIterable {
        case none, rain, snow
    }

  //MARK: - Properties
  var drops = [StormDrop]()
  var lastUpdate = Date.now
  var image: Image

  //MARK: - Init
  init(type: Contents, direction: Angle, strength: Int) {
      switch type {
      case .snow:
          image = Image("snow")
      default:
          image = Image("rain")
      }

      for _ in 0..<strength {
          drops.append(StormDrop(type: type, direction: direction + .degrees(90)))
      }
  }

  //MARK: - Methods
  func update(date: Date, size: CGSize) {
      let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970

      // more code to come

      lastUpdate = date
  }
}


