//
//  MeasureViewModifierView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/09.
//

import SwiftUI

struct MeasureViewModifierView: View {
    @State private var width: Double = 0

    var body: some View {
        VStack {
            Text("Hello, world!")
                .measureSize { size in
                    width = size.width
                }
        }
        .padding()
    }
}

extension View {
    func measureSize(_ callback: @escaping (CGSize) -> Void) -> some View {
        modifier(MeasureSizeModirider(callback: callback))
    }
}

struct MeasureSizeModirider: ViewModifier {
    var callback: (CGSize) -> Void

    func body(content: Content) -> some View {
        content
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            callback(proxy.size)
                        }
                }
            }
    }
}

struct MeasureViewModifierView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureViewModifierView()
    }
}
