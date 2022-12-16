//
//  CustomEnvironmentKeys.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/05.
//

import SwiftUI


fileprivate struct CustomEnvironmentKeysApp: View {
    @Environment(\.safeArea) var safeArea

    var body: some View {
        ZStack {}
            .environment(\.safeArea, safeArea)
    }
}

/*
 1. EnvironmentKeyに準拠した構造体を作成
 2. Keyに対してEnvironment Valueを作成
 3. 任意の場所で使う
 */
fileprivate struct SafeAreaValue: EnvironmentKey {
    static var defaultValue: EdgeInsets = .init(.zero)
}

extension EnvironmentValues {
    var safeArea: EdgeInsets {
        get {
            self[SafeAreaValue.self]
        }

        set {
            self[SafeAreaValue.self] = newValue
        }
    }
}
