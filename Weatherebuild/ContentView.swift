//
//  ContentView.swift
//  Weatherebuild
//
//  Created by Николай Никитин on 23.11.2022.
//

import SwiftUI

struct ContentView: View {

  //MARK: - View Properties
  @State private var cloudThickness = Cloud.Thickness.regular

  //MARK: - View Body
    var body: some View {
        ZStack {
          CloudsView(thickness: .regular)
        }
        .preferredColorScheme(.dark)
        .background(.blue)
        .safeAreaInset(edge: .bottom) {
          VStack {
            Picker("Thickness", selection: $cloudThickness) {
              ForEach(Cloud.Thickness.allCases, id: \.self) {thickness in
                Text(String(describing: thickness).capitalized)
              }
            }
            .pickerStyle(.segmented)
            .padding(5)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
