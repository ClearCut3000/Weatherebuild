//
//  LightningView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 02.12.2022.
//

import SwiftUI

struct LightningView: View {
  //MARK: - View Properties
  var lightning: Lightning

  //MARK: - View Init
  init() {
      lightning = Lightning()
  }

  //MARK: - View Body
    var body: some View {
      TimelineView(.animation) { timeline in
        Canvas { context, size in
          lightning.update(date: timeline.date, in: size)

          for bolt in lightning.bolts {
            var path = Path()
            path.addLines(bolt.points)
            context.stroke(path, with: .color(.white), lineWidth: bolt.width)
          }
        }
      }
      .ignoresSafeArea()
      .onTapGesture {
        lightning.strike()
      }
    }
}

struct LightningView_Previews: PreviewProvider {
    static var previews: some View {
        LightningView()
    }
}
