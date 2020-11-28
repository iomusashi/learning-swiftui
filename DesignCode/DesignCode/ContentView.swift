//
//  ContentView.swift
//  DesignCode
//
//  Created by インヤキ on 11/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State var cardShown = false
  
  var body: some View {
    ZStack {
      TitleView(
        blurRadius: cardShown ? 20 : 0
      )
      .animation(.default)

      BackCardView(
        offset: CGPoint(x: 0, y: cardShown ? -400 : -40),
        backgroundColor: Color("card4"),
        scaleFactor: 0.9,
        rotationDegree: cardShown ? 0 : 10
      )
      .animation(.easeInOut(duration: 0.4))

      BackCardView(
        offset: CGPoint(x: 0, y: cardShown ? -200 : -20),
        backgroundColor: Color("card3"),
        scaleFactor: 0.95,
        rotationDegree: cardShown ? 0 : 5
      )
      .animation(.easeInOut(duration: 0.3))

      CardView()
        .onTapGesture {
          cardShown.toggle()
        }
      
      BottomCardView(
        blurRadius: cardShown ? 20 : 0
      )
      .animation(.default)
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

struct TitleView: View {
  
  var blurRadius: CGFloat = .zero
  
  var body: some View {
    VStack {
      HStack {
        Text("Certificates")
          .font(.largeTitle)
          .fontWeight(.bold)
        Spacer()
      }
      .padding()
      Image("Background1")
      Spacer()
    }
    .blur(radius: blurRadius)
  }
}

struct BottomCardView: View {
  
  var blurRadius: CGFloat = .zero
  
  var body: some View {
    VStack(spacing: 20.0) {
      Rectangle()
        .frame(width: 40, height: 5)
        .cornerRadius(3)
        .opacity(0.1)
      
      Text("This certificate is proof that you have achieved the UI Design course with approval from a Design+Code instructor.")
        .multilineTextAlignment(.center)
        .font(.subheadline)
      Spacer()
    }
    .padding(.top, 8)
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .cornerRadius(30)
    .shadow(radius: 20)
    .offset(x: 0, y: 500)
    .blur(radius: blurRadius)
  }
}
