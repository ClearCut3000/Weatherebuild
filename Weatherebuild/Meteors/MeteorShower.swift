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
    ///  create meteors from both sides of the screen
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

    for meteor in meteors {
      /// Adjust the meteor’s X position upwards or downwards based on whether it’s moving to the right
      if meteor.isMovingRight {
        meteor.x += delta * meteor.speed
      } else {
        meteor.x -= delta * meteor.speed
      }
      /// Subtract some amount from its speed
      meteor.speed -= delta * 900
      /// If the speed has reached 0, remove the meteor from the set
      if meteor.speed < 0 {
        meteors.remove(meteor)
        /// Otherwise, if the meteor’s length is less than 100, make it longer
      } else if meteor.length < 100 {
        meteor.length += delta * 300
      }
    }

    lastUpdate = date
  }
}
