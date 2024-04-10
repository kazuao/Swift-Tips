//
//  FavoriteButton.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/06/07.
//

import SwiftUI
// ref: `https://gist.github.com/chriseidhof/5c9945f17d634bb9c4a56050a02c3e52`


extension CGPoint {
    static func *(lhs: Self, rhs: CGFloat) -> Self {
        .init(x: lhs.x * rhs, y: lhs.y * rhs)
    }
}


struct MoveToModifier: ViewModifier & Animatable {

    var offset: CGFloat
    var progress: CGFloat

    init(offset: CGFloat, active: Bool) {
        self.offset = offset
        self.progress = active ? 1 : 0
    }

    var maxYOffset: CGFloat = 40

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        let amount = sin(.pi * progress) * maxYOffset
        content.offset(x: offset * progress, y: amount)
    }
}


struct StarButton: View {

    @State private var selected: Bool = false

    var body: some View {
        let moveTo = AnyTransition
            .modifier(active: MoveToModifier(offset: 70, active: true),
                      identity: MoveToModifier(offset: 70, active: false))
        let star = AnyTransition
            .asymmetric(insertion: .identity, removal: moveTo)
            .combined(with: .opacity)

        HStack {
            if !selected {
                Image(systemName: "star")
                    .symbolRenderingMode(.multicolor)
                    .symbolVariant(.fill)
                    .transition(star)
            }

            Text(selected ? "Starred" : "Star")

            Divider()
                .frame(idealHeight: 10)

            Text(selected ? "39": "38")
                .monospacedDigit()
                .id(selected)
                .transition(.scale(scale: 0).combined(with: .opacity))
        }
        .frame(width: 100)
        .animation(.default.speed(0.5), value: selected)
        .foregroundColor(.primary)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.init(white: 0.87))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 5, y: 5)
        )
        .contentShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture {
            selected.toggle()
        }
    }
}


struct FavoriteButton: View {
    var body: some View {
        StarButton()
            .fixedSize()
            .padding(100)
            .background(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .preferredColorScheme(.light)
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton()
    }
}
