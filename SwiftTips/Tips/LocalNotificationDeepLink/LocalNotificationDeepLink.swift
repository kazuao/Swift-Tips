//
//  LocalNotificationDeepLink.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/05/01.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addOfferNotification() {
        let content = UNMutableNotificationContent()
        content.title = String(localized: "offerTitle")
        content.body = String(localized: "offerBody")
        content.userInfo = ["url": "myapp://offer"]
        
        let request = UNNotificationRequest(
            identifier: "offer",
            content: content,
            trigger: UNTimeIntervalNotificationTrigger(
                timeInterval: 1800,
                repeats: false
            )
        )
        add(request)
    }
}

