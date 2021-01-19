//
//  ContentView.swift
//  DesignCode
//
//  Created by インヤキ on 11/26/20.
//

import SwiftUI

struct ContentView: View {
  
  @State var cardShown = false
  @State var dragBoxSize = CGSize.zero
  @State var descriptionShown = false
  @State var bottomCardDragBoxSize = CGSize.zero
  
  var body: some View {
    ZStack {
      TitleView(
        blurRadius: cardShown ? 20 : 0,
        opacity: descriptionShown ? 0.4 : 1.0,
        offset: CGPoint(x: 0, y: descriptionShown ? -200 : 0)
      )
      .animation(
        .timingCurve(0.2, 0.8, 0.2, 1.0, duration: 0.8)
      )

      BackCardView(
        offset: CGPoint(x: 0, y: cardShown ? -400 : -40),
        backgroundColor: Color("card4"),
        scaleFactor: 0.9,
        rotationDegree: cardShown || descriptionShown ? 0 : 10,
        dragOffset: dragBoxSize,
        frameSize: CGSize(width: descriptionShown ? 375 : 340, height: 220),
        expansionOffset: CGPoint(x: 0, y: descriptionShown ? -140 : 0)
      )
      .animation(.easeInOut(duration: 0.4))

      BackCardView(
        offset: CGPoint(x: 0, y: cardShown ? -200 : -20),
        backgroundColor: Color("card3"),
        scaleFactor: 0.95,
        rotationDegree: cardShown || descriptionShown ? 0 : 5,
        dragOffset: dragBoxSize,
        frameSize: CGSize(width: descriptionShown ? 375 : 340, height: 220),
        expansionOffset: CGPoint(x: 0, y: descriptionShown ? -120 : 0)
      )
      .animation(.easeInOut(duration: 0.3))

      CardView(
        dragOffset: dragBoxSize,
        frameSize: CGSize(width: descriptionShown ? 375 : 340, height: 220),
        expansionOffset: CGPoint(x: 0, y: descriptionShown ? -100 : 0)
      )
      .onTapGesture {
        descriptionShown.toggle()
      }
      .gesture(
        DragGesture()
          .onChanged { value in
            descriptionShown = false
            onCardDragChanged(offset: value.translation)
          }
          .onEnded { value in
            onCardDragEnded()
          }
      )
      .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0.0))

      BottomCardView(
        blurRadius: cardShown ? 20 : 0,
        offset: CGPoint(x: 0, y: descriptionShown ? 360 : 1000),
        dragOffset: bottomCardDragBoxSize
      )
      .gesture(
        DragGesture()
          .onChanged { value in
            bottomCardDragBoxSize.height = value.translation.height < -120 ? -120 : value.translation.height
          }
          .onEnded { value in
            if bottomCardDragBoxSize.height > 50 {
              descriptionShown = false
            }
            bottomCardDragBoxSize = .zero
          }
      )
      .animation(
        .timingCurve(0.2, 0.8, 0.2, 1.0, duration: 0.8)
      )
    }
  }
  
  func onCardDragChanged(offset: CGSize) {
    self.dragBoxSize = offset
    self.cardShown = offset.height >= -50
  }
  
  func onCardDragEnded() {
    self.dragBoxSize = .zero
    self.cardShown = false
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct CardView: View {
  
  var dragOffset: CGSize = .zero
  var frameSize: CGSize = CGSize(width: 340, height: 220)
  var expansionOffset: CGPoint = .zero

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
    .frame(width: frameSize.width, height: frameSize.height)
    .background(Color.black)
    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    .shadow(radius: 20)
    .offset(dragOffset)
    .offset(x: expansionOffset.x, y: expansionOffset.y)
    .blendMode(.hardLight)
  }
}

struct BackCardView: View {
  
  var offset: CGPoint = .zero
  var backgroundColor: Color = .blue
  var scaleFactor: CGFloat = 1.0
  var rotationDegree: Double = .zero
  var dragOffset: CGSize = .zero
  var frameSize: CGSize = CGSize(width: 340, height: 220)
  var expansionOffset: CGPoint = .zero

  var body: some View {
    VStack {
      Spacer()
    }
    .frame(width: frameSize.width, height: frameSize.height)
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
    .offset(dragOffset)
    .offset(x: expansionOffset.x, y: expansionOffset.y)
    .blendMode(.hardLight)
  }
}

struct TitleView: View {
  
  var blurRadius: CGFloat = .zero
  var opacity: Double = 1.0
  var offset: CGPoint = .zero
  
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
    .offset(x: offset.x, y: offset.y)
    .blur(radius: blurRadius)
    .opacity(opacity)
  }
}

struct BottomCardView: View {
  
  var blurRadius: CGFloat = .zero
  var offset: CGPoint = .zero
  var dragOffset: CGSize = .zero
  
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
    .offset(x: offset.x, y: offset.y)
    .offset(dragOffset)
    .blur(radius: blurRadius)
  }
}
