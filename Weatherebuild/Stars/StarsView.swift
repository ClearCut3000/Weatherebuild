//
//  StarsView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 27.11.2022.
//

import SwiftUI

struct StarsView: View {

  //MARK: - View Properties
  @State private var starField = StarField()

  //MARK: - View Body
    var body: some View {
      TimelineView { timeline in
        Canvas { context, size in
          starField.update(date: timeline.date)
          context.addFilter(.blur(radius: 0.3))
          for (index, star) in starField.stars.enumerated() {
            let path = Path(ellipseIn: CGRect(x: star.x, y: star.y, width: star.size, height: star.size))
            if index.isMultiple(of: 7) {
              context.fill(path, with: .color(red: 1, green: 0.85, blue: 0.8))
            } else {
              context.fill(path, with: .color(white: 1))
            }
          }
        }
      }
      .ignoresSafeArea()
      .mask(
        LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom)
      )
    }
}

struct StarsField_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
