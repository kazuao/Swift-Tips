//
//  ButtonActionInSwiftUIView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/24.
//

import SwiftUI

struct ButtonActionInSwiftUIView: View {
    
    @State private var tapCount: Int = 0

    var body: some View {
        VStack {
            Text("\(tapCount) taps")

            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0...100, id: \.self) { _ in
                        listItem
                            .onLongPressGesture {
                                print("Tap")
                            }
                    }
                }
            }
        }
    }

    var listItem: some View {
        Color.red
            .frame(width: 100, height: 100)
    }
}

struct GestureButton<Label: View>: View {

    var label: () -> Label
    var style: GestureButtonStyle
    var releaseAction: () -> Void

    init(doubleTapTimeout: TimeInterval = 0.5,
         longPressTime: TimeInterval = 1,
         pressAction: @escaping () -> Void = {},
         releaseAction: @escaping () -> Void = {},
         longPressAction: @escaping () -> Void = {},
         doubleTapAction: @escaping () -> Void = {},
         endAction: @escaping () -> Void = {},
         label: @escaping () -> Label
    ) {
        self.style = .init(pressAction: pressAction,
                           longPressTime: longPressTime,
                           longPressAction: longPressAction,
                           doubleTapTimeout: doubleTapTimeout,
                           doubleTapAction: doubleTapAction,
                           endAction: endAction)
        self.releaseAction = releaseAction
        self.label = label
    }

    var body: some View {
        Button(action: releaseAction, label: label)
            .buttonStyle(style)
    }
}

struct GestureButtonStyle: ButtonStyle {

    private var doubleTapTimeout: TimeInterval
    private var longPressTime: TimeInterval

    private var pressAction: () -> Void
    private var longPressAction: () -> Void
    private var doubleTapAction: () -> Void
    private var endAction: () -> Void

    init(pressAction: @escaping () -> Void,
         longPressTime: TimeInterval,
         longPressAction: @escaping () -> Void,
         doubleTapTimeout: TimeInterval,
         doubleTapAction: @escaping () -> Void,
         endAction: @escaping () -> Void
    ) {
        self.pressAction = pressAction
        self.longPressTime = longPressTime
        self.longPressAction = longPressAction
        self.doubleTapTimeout = doubleTapTimeout
        self.doubleTapAction = doubleTapAction
        self.endAction = endAction
    }

    @State private var doubleTapDate: Date = .init()
    @State private var longPressDate: Date = .init()

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { isPressed in
                if isPressed {
                    pressAction()
                    doubleTapDate = tryTriggerDoubleTap() ? .distantPast : .now
                    tryTriggerLongPressAfterDelay(triggered: longPressDate)
                } else {
                    endAction()
                }
            }
    }
}

private extension GestureButtonStyle {

    func tryTriggerDoubleTap() -> Bool {
        let interval = Date().timeIntervalSince(doubleTapDate)

        guard interval < doubleTapTimeout else { return false }

        doubleTapAction()
        return true
    }

    func tryTriggerLongPressAfterDelay(triggered date: Date) {
        DispatchQueue.main.asyncAfter(deadline: .now() + longPressTime) {
            guard date == longPressDate else { return }
            longPressAction()
        }
    }
}

struct ButtonActionInSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonActionInSwiftUIView()
    }
}
