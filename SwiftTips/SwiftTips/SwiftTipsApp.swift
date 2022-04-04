//
//  SwiftTipsApp.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

@main
struct SwiftTipsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onContinueUserActivity(UserActivityView.userActivity) { userActivity in
                    if let id = userActivity.userInfo?["id"] {
                            // アプリの状態を変更する
                    }
                }
        }
    }
}
