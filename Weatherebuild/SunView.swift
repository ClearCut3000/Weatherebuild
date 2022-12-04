//
//  SunView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 05.12.2022.
//

import SwiftUI

struct SunView: View {

  //MARK: - View Properties
  let progress: Double

  //MARK: - View Body
    var body: some View {
      GeometryReader { proxy in
                  ZStack {
                      Image("halo")
                      Image("sun")
                  }
                  .blendMode(.screen)
                  .ignoresSafeArea()
                  .position(x: proxy.frame(in: .global).width * progress, y: 50)
                  .rotationEffect(.degrees((progress - 0.5) * 180))
              }
    }
}

struct SunView_Previews: PreviewProvider {
    static var previews: some View {
      SunView(progress: 0.5)
    }
}
