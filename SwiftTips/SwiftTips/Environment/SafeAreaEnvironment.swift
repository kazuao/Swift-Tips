//
//  SafeAreaEnvironment.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/05/09.
//

import SwiftUI

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .filter(\.isKeyWindow)
            .first
    }
}

extension UIEdgeInsets {
    var edgeInsets: EdgeInsets {
        .init(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        UIApplication.shared.keyWindow?.safeAreaInsets.edgeInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

/* Usage */
private struct ExampleView: View {
    @Environment(\.safeAreaInsets) var safeAreaInsets

    var body: some View {
        Text("ステータスバーの高さは\(safeAreaInsets.top)です")
    }
}
