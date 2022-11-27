//
//  CloudsView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 24.11.2022.
//

import SwiftUI

struct CloudsView: View {

  //MARK: - View Properties
  var cloudGroup: CloudGroup


  //MARK: - View Body
  var body: some View {
    TimelineView(.animation) { timeline in
      Canvas { context, size in
        context.opacity = cloudGroup.opacity
        cloudGroup.update(with: timeline.date)

        let resolvedImage = (0..<8).map { i -> GraphicsContext.ResolvedImage in
          let sorceImage = Image("cloud\(i)")
          let resolved = context.resolve(sorceImage)
          return resolved
        }

        for cloud in cloudGroup.clouds {
          context.translateBy(x: cloud.position.x, y: cloud.position.y)
          context.scaleBy(x: cloud.scale, y: cloud.scale)
          context.draw(resolvedImage[cloud.imageNumber], at: .zero, anchor: .topLeading)
          context.transform = .identity
        }
      }
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  init(thickness: Cloud.Thickness) {
    cloudGroup = CloudGroup(thickness: thickness)
  }
}

struct CloudsView_Previews: PreviewProvider {
    static var previews: some View {
      CloudsView(thickness: .regular)
        .background(.blue)
    }
}
