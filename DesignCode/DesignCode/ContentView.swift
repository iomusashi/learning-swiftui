//
//  ContentView.swift
//  DesignCode
//
//  Created by インヤキ on 11/26/20.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      BackCardView(
        offset: CGPoint(x: 0, y: -40),
        backgroundColor: Color("card4"),
        scaleFactor: 0.9,
        rotationDegree: 10
      )

      BackCardView(
        offset: CGPoint(x: 0, y: -20),
        backgroundColor: Color("card3"),
        scaleFactor: 0.95,
        rotationDegree: 5
      )

      CardView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CardView: View {
  var body: some View {
    VStack {
      HStack {
        VStack(alignment: .leading) {
          Text("UI Design")
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
          Text("Certificate")
            .foregroundColor(Color("accent"))
        }
        Spacer()
        Image("Logo1")
      }
      .padding()
      
      Spacer()
      Image("Card1")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 110, alignment: .top)
    }
    .frame(width: 340, height: 220)
    .background(Color.black)
    .cornerRadius(20)
    .shadow(radius: 20)
    .blendMode(.hardLight)
  }
}

struct BackCardView: View {
  
  var offset: CGPoint = .zero
  var backgroundColor: Color = .blue
  var scaleFactor: CGFloat = 1.0
  var rotationDegree: Double = .zero

  var body: some View {
    VStack {
      Spacer()
    }
    .frame(width: 340, height: 220)
    .background(backgroundColor)
    .cornerRadius(20)
    .shadow(radius: 20)
    .offset(x: offset.x, y: offset.y)
    .scaleEffect(scaleFactor)
    .rotationEffect(.degrees(rotationDegree))
    .rotation3DEffect(
      .degrees(rotationDegree),
      axis: (x: CGFloat(rotationDegree), y: 0.0, z: 0.0)
    )
    .blendMode(.hardLight)
  }
}
