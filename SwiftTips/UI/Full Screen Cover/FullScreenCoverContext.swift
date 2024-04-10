////
////  FullScreenCoverContext.swift
////  SwiftTips
////
////  Created by kazunori.aoki on 2022/04/28.
////
//
//import SwiftUI
//
//// ref: https://danielsaidi.com/blog/2020/10/28/swiftui-full-screen-covers?utm_source=swiftlee&utm_medium=swiftlee_weekly&utm_campaign=issue_112
//
//@available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
//class FullScreenCoverContext: PresentationContext<AnyView> {
//    func present<Cover: View>(_ cover: @autoclosure @escaping () -> Cover) {
//        presentContent(cover().any())
//    }
//
//    func present(_ provider: FullScreenCoverProvider) {
//        present(provider.cover)
//    }
//}
