//
//  Lightning.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 02.12.2022.
//

import SwiftUI

class Lightning {
  enum LightningState {
    case waiting, striking, fading
  }

  //MARK: - Properties
  var bolts = [LightningBolt]()
  var state = LightningState.waiting
  var lastUpdate = Date.now

  //MARK: - Methods
  /// Animates the lightning effect over time
  func update(date: Date, in size: CGSize) {
    let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
    lastUpdate = date

    switch state {
    case .waiting:
      break

    case .striking:
      let speed = delta * 800
      var hasFinishedStriking = true

      for bolt in bolts {
        guard var lastPoint = bolt.points.last else { continue }

        for _ in 0..<5 {
          let endX = lastPoint.x + (speed * cos(bolt.angle))
          let endY = lastPoint.y - sin(speed * sin(bolt.angle))
          lastPoint = CGPoint(x: endX, y: endY)
          bolt.points.append(lastPoint)
        }
        if lastPoint.y < size.height {
            hasFinishedStriking = false
        }
      }
      if hasFinishedStriking {
          state = .fading
      }

    case .fading:
      state = .waiting
      bolts.removeAll(keepingCapacity: true)
    }
  }

  /// Creates a lightning bolt on demand
  func strike() {
      guard bolts.isEmpty else { return }
      state = .striking

      let startPosition = CGPoint(x: 200, y: 0)
      let newBolt = LightningBolt(start: startPosition, width: 5, angle: Angle.degrees(270).radians)
      bolts.append(newBolt)
  }
}
