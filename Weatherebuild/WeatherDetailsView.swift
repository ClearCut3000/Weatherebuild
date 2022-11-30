//
//  WeatherDetailsView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 01.12.2022.
//

import SwiftUI

struct WeatherDetailsView: View {

  //MARK: - View Properties
  /// The color we'll be using to tint our background
  let tintColor: Color
  /// What type of residue to create, and its strength
  let residueType: Storm.Contents
  let residueStrength: Double

  //MARK: - View Body
  var body: some View {
    ScrollView {
      VStack(spacing: 0) {
        ResidueView(type: residueType, strength: residueStrength)
                            .frame(height: 62)
                            .offset(y: 30)
                            .zIndex(1)

        RoundedRectangle(cornerRadius: 25)
                           .fill(tintColor.opacity(0.25))
                           .frame(height: 800)
                           .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 25))
                           .padding(.horizontal, 20)
      }
      .padding(.top, 200)
    }
  }
}

struct WeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
      WeatherDetailsView(tintColor: .gray, residueType: .rain, residueStrength: 200)
    }
}
