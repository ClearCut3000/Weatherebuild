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
  @State private var time = 0.0

  let backgroundTopStops: [Gradient.Stop] = [
    .init(color: .sunriseStart, location: 0)
  ]
  let backgroundBottomStops: [Gradient.Stop] = [
    .init(color: .sunriseEnd, location: 0)
  ]

  var formattedTime: String {
    let start = Calendar.current.startOfDay(for: Date.now)
    let advanced = start.addingTimeInterval(time * 24 * 60 * 60)
    return advanced.formatted(date: .omitted, time: .shortened)
  }

  //MARK: - View Body
    var body: some View {
        ZStack {
          CloudsView(thickness: .regular)
        }
        .preferredColorScheme(.dark)
        .background( LinearGradient(colors: [
          backgroundTopStops.interpolated(amount: time),
          backgroundBottomStops.interpolated(amount: time)
        ], startPoint: .top, endPoint: .bottom))
        .safeAreaInset(edge: .bottom) {
          VStack {
            Text(formattedTime)
              .padding(.top)
            Picker("Thickness", selection: $cloudThickness) {
              ForEach(Cloud.Thickness.allCases, id: \.self) {thickness in
                Text(String(describing: thickness).capitalized)
              }
            }
            .pickerStyle(.segmented)
            HStack {
              Text("Time:")
              Slider(value: $time)
            }
            .padding()
          }
          .padding(5)
          .frame(maxWidth: .infinity)
          .background(.regularMaterial)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
