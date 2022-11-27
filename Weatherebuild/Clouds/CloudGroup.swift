//
//  CloudGroup.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 24.11.2022.
//

import Foundation

class CloudGroup {

  //MARK: - Properties
  var clouds = [Cloud]()
  let opacity: Double
  var lastUpdate = Date.now

  //MARK: - Init
  init(thickness: Cloud.Thickness) {
    let cloudsToCreate: Int
    let cloudsScale: ClosedRange<Double>

    switch thickness {
    case .none:
      cloudsToCreate = 0
      opacity = 1
      cloudsScale = 1...1
    case .thin:
      cloudsToCreate = 10
      opacity = 0.6
      cloudsScale = 0.2...0.4
    case .light:
      cloudsToCreate = 10
      opacity = 0.7
      cloudsScale = 0.4...0.6
    case .regular:
      cloudsToCreate = 15
      opacity = 0.8
      cloudsScale = 0.7...0.9
    case .thick:
      cloudsToCreate = 25
      opacity = 0.9
      cloudsScale = 1.0...1.3
    case .ultra:
      cloudsToCreate = 40
      opacity = 1
      cloudsScale = 1.2...1.6
    }

    for i in 0..<cloudsToCreate {
      let scale = Double.random(in: cloudsScale)
      let imageNumber = i % 8
      let cloud = Cloud(imageNumber: imageNumber, scale: scale)
      clouds.append(cloud)
    }
  }

  //MARK: - Methods
  func update(with date: Date) {
    let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
    for cloud in clouds {
      cloud.position.x -= delta * cloud.speed
      let offScreenDistance = max(400, 400 * cloud.scale)
      if cloud.position.x < -offScreenDistance {
        cloud.position.x = offScreenDistance
      }
    }
    lastUpdate = date
  }
}
