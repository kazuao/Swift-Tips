//
//  DynamicStackView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/01/05.
//

import SwiftUI

struct DynamicStackView: View {
    var body: some View {
        DynamicStack {
            Text("hogehogehoge")
            Text("hogehogehoge")
            Text("hogehogehoge")
            Text("hogehogehoge")
            Text("hogehogehoge")
        }
    }
}

struct DynamicStack<Content: View>: View {
    @DynamicOrientation var orientation

    var hAlignment: HorizontalAlignment = .center
    var vAlignment: VerticalAlignment = .center
    var spacing: CGFloat?

    @ViewBuilder var content: () -> Content

    var body: some View {
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            HStack(alignment: vAlignment, spacing: spacing, content: content)
        case _:
            VStack(alignment: hAlignment, spacing: spacing, content: content)
        }
    }
}

@propertyWrapper
struct DynamicOrientation: DynamicProperty {
    @ObservedObject var orientation = DeviceOrientation.shared
    var wrappedValue: InterfaceOrientation { orientation.value }
}

@MainActor
final class DeviceOrientation: ObservableObject {
    @Published private(set) var value: InterfaceOrientation = .init(UIDevice.current.orientation) ?? .portrait

    static let shared = DeviceOrientation()
    private init() {
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { _ in InterfaceOrientation(UIDevice.current.orientation)}
            .assign(to: &$value)
    }
}

private extension InterfaceOrientation {
    init?(_ orientation: UIDeviceOrientation) {
        switch orientation {
        case .portrait:
            self = .portrait
        case .portraitUpsideDown:
            self = .portraitUpsideDown
        case .landscapeLeft:
            self = .landscapeLeft
        case .landscapeRight:
            self = .landscapeRight
        default:
            return nil
        }
    }
}

struct DynamicStackView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicStackView()
    }
}
