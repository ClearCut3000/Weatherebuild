//
//  ResidueView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 01.12.2022.
//

import SwiftUI

struct ResidueView: View {

  //MARK: - View Properties
  var residue: Residue

  //MARK: - View Init
  init(type: Storm.Contents, strength: Double) {
    residue = Residue(type: type, strength: strength)
  }

  //MARK: - View Body
  var body: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        residue.update(date: timeline.date, size: size)
        for drop in residue.drops {
          var contextCopy = context
          let xPos = drop.x * size.width
          let yPos = drop.y * size.height

          contextCopy.opacity = drop.opacity
          contextCopy.translateBy(x: xPos, y: yPos)
          contextCopy.scaleBy(x: drop.scale, y: drop.scale)
          contextCopy.draw(residue.image, at: .zero)
        }
      }
    }
  }
}

struct ResidueView_Previews: PreviewProvider {
  static var previews: some View {
    ResidueView(type: .rain, strength: 200)
  }
}
