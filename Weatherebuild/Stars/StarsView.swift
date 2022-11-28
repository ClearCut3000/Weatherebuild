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
      Canvas { context, size in
          for star in starField.stars {
              let path = Path(ellipseIn: CGRect(x: star.x, y: star.y, width: star.size, height: star.size))

              context.fill(path, with: .color(white: 1))
          }
      }
      .ignoresSafeArea()
    }
}

struct StarsField_Previews: PreviewProvider {
    static var previews: some View {
        StarsView()
    }
}
