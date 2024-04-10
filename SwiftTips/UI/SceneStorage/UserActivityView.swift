//
//  UserActivityView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/03/18.
//

import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let title: String
}

struct UserActivityView: View {

    static let userActivity = "com.aaplab.app.purchase"
    let product: Product

    @State private var isPurchaseLinkActivated = false

    var body: some View {
        VStack {
            Text(product.title)

            NavigationLink(isActive: $isPurchaseLinkActivated) {
                CheckoutView()
            } label: {
                Label("Go to checkout", systemImage: "creditcard")
            }
        }
        .userActivity(UserActivityView.userActivity,
                      isActive: isPurchaseLinkActivated) { userActivity in
            userActivity.title = "Purchase \(product.title)"
            userActivity.userInfo = ["id": product.id]
        }
    }

    /*
     mainでこう書く
     
     ContentView()
         .onContinueUserActivity(UserActivityView.userActivity) { userActivity in
             if let id = userActivity.userInfo?["id"] {
                     // アプリの状態を変更する
             }
         }
 }     */
}

struct CheckoutView: View {
    var body: some View {
        Text("")
    }
}

struct UserActivityView_Previews: PreviewProvider {
    static var previews: some View {
        UserActivityView(product: .init(title: "sample user activity"))
    }
}
