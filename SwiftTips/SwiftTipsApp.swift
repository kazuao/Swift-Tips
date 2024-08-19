//
//  SwiftTipsApp.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

@main
struct SwiftTipsApp: App {
    
    // Local Notification DeepLink
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    @AppStorage("launches") private var launches = 0
    @State private var offerShown: Bool = false

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
                        launches += 1
                    case .inactive:
                        print("App is inactive")
                    case .background:
                        print("App is background")
                    case .background where launches == 1:
                        UNUserNotificationCenter.current().addOfferNotification()
                    @unknown default:
                        print("interesting: I received an unexpected new value")
                    }
                }
                .onOpenURL { url in
                    // deep linkの処理
                    print("Received URL: \(url)")
                    
                    if let host = url.host(), host == "offer" {
                        offerShown = true
                    }
                }
                .sheet(isPresented: $offerShown) {
                    
                }
        }
    }
}

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        guard let urlString = response.notification.request.content.userInfo["url"] as? String,
              let url = URL(string: urlString)
        else {
            return
        }
        
        await UIApplication.shared.open(url)
    }
}
