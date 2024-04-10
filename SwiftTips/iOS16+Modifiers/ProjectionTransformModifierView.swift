//
//  Modifier5ViewSwiftUIView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

struct ProjectionTransformModifierView: View {

    @State private var skew: CGFloat = 0

    var body: some View {
        Rectangle()
            .fill(.red.gradient)
            .frame(width: 220, height: 220)
        // MARK: Used for 3D transforms
        // We can use UIKit CGAffineTransform
        // Call it under Modifier
            .modifier(CustomProjection(b: skew))
            .onTapGesture {
                withAnimation(.easeInOut(duration: 5)) {
                    skew = 1
                }
            }
    }
}

// MARK: For adding animation in projection effect -> Use geometry effect
struct CustomProjection: GeometryEffect {
    // Same as shape animation
    var b: CGFloat
    var animatableData: CGFloat {
        get { b }
        set { b = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        return .init(.init(1, b, 0, 1, 0, 0))
    }
}

struct Modifier5ViewSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectionTransformModifierView()
    }
}
