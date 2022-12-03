//
//  Lightning.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 02.12.2022.
//

import SwiftUI

class Lightning {
  enum LightningState {
    case waiting, preparing, striking, fading
  }

  //MARK: - Properties
  var bolts = [LightningBolt]()
  var state = LightningState.waiting
  var lastUpdate = Date.now
  var flashOpacity = 0.05

  //MARK: - Methods
  /// Animates the lightning effect over time
  func update(date: Date, in size: CGSize) {
    let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
    lastUpdate = date

    switch state {
    case .waiting:
      break

    case .preparing:
      let startPosotion = CGPoint(x: Double.random(in: 50...size.width - 50), y: 0)
      let newBolt = LightningBolt(start: startPosotion, width: 5, angle: Angle.degrees(270).radians)
      bolts.append(newBolt)
      state = .striking

    case .striking:
      let speed = delta * 800
      var hasFinishedStriking = true

      for bolt in bolts {
        guard var lastPoint = bolt.points.last else { continue }

        for _ in 0..<5 {
          let endX = lastPoint.x + (speed * cos(bolt.angle)) + Double.random(in: -15...15)
          let endY = lastPoint.y - (speed * sin(bolt.angle)) + Double.random(in: -15...15)
          lastPoint = CGPoint(x: endX, y: endY)
          bolt.points.append(lastPoint)
        }
        if lastPoint.y < size.height {
          hasFinishedStriking = false
          /// Create a fork
          if bolts.count < 4 && Int.random(in: 0..<100) <= 20 {
            /// Pick a new angle for the forked segment
            let newAngle = Double.random(in: -.pi / 4 ... .pi / 4) - .pi / 2
            /// Creating a new lightningBolt object with its start position set to lastPoint and its width set to 75% of our current width so that forked bolts get slimmer
            let newBolt = LightningBolt(start: lastPoint, width: bolt.width * 0.75, angle: newAngle)
            /// Add that to our bolts array so we update and render it
            bolts.append(newBolt)
          }
        }
      }
      if hasFinishedStriking {
        state = .fading
        flashOpacity = 0.6
        /// increase the width of all bolts by 50% to give them some extra visual energy
        for bolt in bolts {
          bolt.width *= 1.5
        }
      }

    case .fading:
      var allFaded = true
      flashOpacity -= delta
      ///  fades out all the bolts until they are all invisible
      for bolt in bolts {
        bolt.width -= delta * 15

        if bolt.width > 0.05 {
          allFaded = false
        }
      }
      /// when that has happened will clear the bolts array and change state
      if allFaded && flashOpacity <= 0 {
        state = .waiting
        bolts.removeAll(keepingCapacity: true)
      }
    }
  }

  /// Creates a lightning bolt on demand
  func strike() {
    guard state == .waiting else { return }
    state = .preparing
  }
}
