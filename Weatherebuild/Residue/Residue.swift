//
//  Residue.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 01.12.2022.
//

import SwiftUI

class Residue {

  //MARK: - Properties
  var drops = Set<ResidueDrop>()
  var lastUpdate = Date.now
  var nextCreationTime = Date.now

  let image = Image("snow")
  let type: Storm.Contents

  let creationAmount: Int
  let lifetime: ClosedRange<Double>
  let creationDelay: ClosedRange<Double>?

  //MARK: - Init
  init(type: Storm.Contents, strength: Double) {
    self.type = type

    switch type {
    case .snow:
      creationAmount = 1
      lifetime = 1.0...2.0
    default:
      creationAmount = 3
      lifetime = 0.9...1.1
    }

    if type == .none || strength == 0 {
      creationDelay = nil
    } else {
      switch strength {
      case 1...200:
        creationDelay = 0...0.25
      case 201...400:
        creationDelay = 0...0.1
      case 401...800:
        creationDelay = 0...0.05
      default:
        creationDelay = 0...0.02
      }
    }
  }

  //MARK: - Methods
  func update(date: Date, size: CGSize) {
    /// don't run any of this code if we aren't creating particles
    guard let creationDelay = creationDelay else { return }

    let currentTime = date.timeIntervalSince1970
    let delta = currentTime - lastUpdate.timeIntervalSince1970
    let divisor = size.height / size.width

    for drop in drops {
      /// increase the Y movement amount based on our time delta, which means the particles will get pulled downwards to simulate gravity
      drop.x += drop.xMovement * drop.speed * delta * divisor
      drop.y += drop.yMovement * drop.speed * delta
      drop.yMovement += delta * 2
      /// If the drop has moved below the half-way point vertically, stop it from moving any further as long as we’re not at the very edges
      if drop.y > 0.5 {
        if drop.x > 0.075 && drop.x < 0.925 {
          drop.y = 0.5
          drop.yMovement = 0
        }
      }
      /// If the destruction time for the particle is less than the current time, destroy it
      if drop.destructionTime < currentTime {
        drops.remove(drop)
      }
    }
    /// create new particles based on the time stored in nextCreationTime
    if nextCreationTime.timeIntervalSince1970 < currentTime {
      /// if that is now before our current time, we need to pick a new X value
      let dropX = Double.random(in: 0.075...0.925)
      /// create creationAmount particles there so we can simulate rain splashes
      for _ in 0..<creationAmount {
        drops.insert(ResidueDrop(type: type, xPosition: dropX, destructionTime: currentTime + .random(in: lifetime)))
      }
      /// then update nextCreationTime to a new data in the future
      nextCreationTime = Date.now + Double.random(in: creationDelay)
    }
    lastUpdate = date
  }
}
