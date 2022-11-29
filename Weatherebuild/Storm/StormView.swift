//
//  StormView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 29.11.2022.
//

import SwiftUI

struct StormView: View {

  //MARK: - View properties
  let storm: Storm

  init(type: Storm.Contents, direction: Angle, strength: Int) {
          storm = Storm(type: type, direction: direction, strength: strength)
      }

  //MARK: View Body
    var body: some View {
      TimelineView(.animation) { timeline in
        Canvas { context, size in
          storm.update(date: timeline.date, size: size)
          for drop in storm.drops {
            var contextCopy = context
            let xPos = drop.x * size.width
            let yPos = drop.y * size.height

            contextCopy.opacity = drop.opacity
            contextCopy.translateBy(x: xPos, y: yPos)
            contextCopy.rotate(by: drop.direction + drop.rotation)
            contextCopy.scaleBy(x: drop.xScale, y: drop.yScale)
            contextCopy.draw(storm.image, at: .zero)
          }
        }
      }
      .ignoresSafeArea()
    }
}

struct StormView_Previews: PreviewProvider {
    static var previews: some View {
      StormView(type: .rain, direction: .zero, strength: 200)
    }
}
