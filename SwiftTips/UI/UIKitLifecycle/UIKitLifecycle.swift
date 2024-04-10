//
//  UIKitLifecycle.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/28.
//

import UIKit
import SwiftUI

// 同じような感じで、viewDidLoadやviewWillDesappearなども作れる
extension View {
    func onViewWillAppear(_ perform: @escaping (() -> Void)) -> some View {
        self.modifier(ViewWillAppearModifier(callback: perform))
    }
}

struct ViewWillAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .background(ViewWillAppearHandler(onWillAppear: callback))
    }
}

struct ViewWillAppearHandler: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIViewController

    let onWillAppear: () -> Void

    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewWillAppearHandler>) -> UIViewController {
        context.coordinator
    }

    func updateUIViewController(_ uiViewController: UIViewController,
                                context: UIViewControllerRepresentableContext<ViewWillAppearHandler>) { }

    
    func makeCoordinator() -> ViewWillAppearHandler.Coordinator {
        Coordinator(onWillAppear: onWillAppear)
    }

    class Coordinator: UIViewController {
        let onWillAppear: () -> Void

        init(onWillAppear: @escaping () -> Void) {
            self.onWillAppear = onWillAppear
            super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear()
        }
    }
}
