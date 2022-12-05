//
//  MeteorShower.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 05.12.2022.
//

import SwiftUI

class MeteorShower {

  //MARK: - Properties
  var meteors = Set<Meteor>()
  var lastUpdate = Date.now

  var lastCreationDate = Date.now
  var nextCreationDelay = Double.random(in: 5...10)

  //MARK: - Methods
  func createMeteor(in size: CGSize) {
    let meteor: Meteor

    if Bool.random() {
      meteor = Meteor(x: 0, y: Double.random(in: 100...200), isMovingRight: true)
    } else {
      meteor = Meteor(x: size.width, y: Double.random(in: 100...200), isMovingRight: false)
    }

    meteors.insert(meteor)
    lastCreationDate = .now
    nextCreationDelay = Double.random(in: 5...10)
  }

  func update(date: Date, size: CGSize) {
      let delta = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970

      if lastCreationDate + nextCreationDelay < .now {
          createMeteor(in: size)
      }

      // update all meteors

      lastUpdate = date
  }
}
