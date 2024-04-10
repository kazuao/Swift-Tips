//
//  MultiDevicePreview.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/25.
//

import SwiftUI

enum Device: String, CaseIterable {
    case iPhone8 = "iPhone 8"
    case iPhone13Mini = "iPhone 13 mini"
    case iPhone13ProMax = "iPhone 13 Pro Max"
    case iPadMini = "iPad mini (6th generation)"
    case iPadPro12 = "iPad Pro (12.9-inch) (5th generation)"
}

struct MultiDevicePreview<Content>: View where Content: View {

    let content: () -> Content
    
    private struct devices: Identifiable {
        let id = UUID()
        let device: PreviewDevice
    }

    private var multiDevices: [devices] {
        return [
            .init(device: .init(rawValue: Device.iPhone13Mini.rawValue)),
            .init(device: .init(rawValue: Device.iPhone13ProMax.rawValue)),
            .init(device: .init(rawValue: Device.iPadMini.rawValue)),
            .init(device: .init(rawValue: Device.iPadPro12.rawValue)),
        ]
    }
    
    var body: some View {
        ForEach(multiDevices, id: \.id) { device in
            content()
                .previewDevice(device.device)
        }
    }
}

// MARK: Usage
struct MultiDevicePreview_Previews: PreviewProvider {
    static var previews: some View {
        MultiDevicePreview {
            PreviewExampleView(isRed: true, isSmall: false)
        }
    }
}
