//
//  ToastBannerView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/06/21.
//

import SwiftUI

struct ToastBannerView: View {
    @State private var showToast: Bool = false

    var body: some View {
        NavigationView {
            List(1..<100) { index in
                Text("Row \(index)")
            }
            .toast(message: "Current time:\n\(Date().formatted(date: .complete, time: .complete))",
                   isShowing: $showToast,
                   duration: Toast.short)
//            .banner(message: "Current time:\n\(Date().formatted(date: .complete, time: .complete))",
//                   isShowing: $showToast,
//                   duration: Toast.short)
            .navigationBarTitle("Toast Testing")
            .navigationBarItems(
                leading: Button("Show") {
                    showToast = true
                }
            )
        }
    }
}

struct ToastBannerView_Previews: PreviewProvider {
    static var previews: some View {
        ToastBannerView()
    }
}
