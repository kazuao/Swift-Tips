//
//  SecureScreenShotView.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/04/04.
//

import SwiftUI

// https://qiita.com/Sossiii/items/ff80cdd8220ae9ff83c1

struct SecureScreenShotView: View {
    var body: some View {
        ScreenShotBlockView {
            Image(systemName: "plus")
        }
    }
}

struct ScreenShotBlockView<Content: View>: View {
    @ViewBuilder var content: Content
    var blurRadius: CGFloat = 15
    
    var body: some View {
        ScreenShotBlockHelper(content: content)
            .background {
                content.blur(radius: blurRadius) // スクショ時に差し替えるView
            }
            .clipped()
            .id(UUID().uuidString) // つけないとScrollViewなどで再描画されない
    }
}

private struct ScreenShotBlockHelper<Content: View>: UIViewRepresentable {
    var content: Content
    
    func makeUIView(context: Context) -> some UIView {
        let secureField = UITextField()
        secureField.isSecureTextEntry = true
        if let textLayoutView = secureField.subviews.first {
            return textLayoutView
        }
        return UIView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let hostingController = UIHostingController(rootView: content)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        uiView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: uiView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: uiView.bottomAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: uiView.trailingAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: uiView.leadingAnchor),
        ])
    }
}

#Preview {
    SecureScreenShotView()
}
