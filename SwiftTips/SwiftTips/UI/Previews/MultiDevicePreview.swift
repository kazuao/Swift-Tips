//
//  MultiDevicePreview.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/25.
//

import SwiftUI

struct MultiDevicePreview<Content>: View where Content: View {

    let content: () -> Content

    private var multiDevices: [PreviewDevice] {
        return [
            .init(rawValue: "iPhone 13 mini"),
            .init(rawValue: "iPhone 13 Pro Max"),
            .init(rawValue: "iPad mini (6th generation)"),
            .init(rawValue: "iPad Pro (12.9-inch) (5th generation)"),
        ]
    }
    
    var body: some View {
        ForEach(multiDevices, id: \.self) { device in
            content()
                .previewDevice(device)
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
