//
//  SwiftTipsApp.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

@main
struct SwiftTipsApp: App {

    // アプリ全体のライフサイクルを取得できる
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity(UserActivityView.userActivity) { userActivity in
                    if let _ = userActivity.userInfo?["id"] {
                            // アプリの状態を変更する
                    }
                }
                .onChange(of: scenePhase) { _, newScenePhase in
                    switch newScenePhase {
                    case .active:
                        print("App is active")
                    case .inactive:
                        print("App is inactive")
                    case .background:
                        print("App is background")
                    @unknown default:
                        print("interesting: I received an unexpected new value")
                    }
                }
                .onOpenURL { url in
                    // deep linkの処理
                    print("Received URL: \(url)")
                }
        }
    }
}
