////
////  WebView.swift
////  SwiftTips
////
////  Created by kazunori.aoki on 2022/12/16.
////
//
//import SwiftUI
//import WebKit
//
//struct WebViewContentView: View {
//
//    @StateObject var webViewState = WebViewState { webView in
//        // 💡 If you want to more configuration
//        // example
//        webView.allowsBackForwardNavigationGestures = true
//    }
//
//    private let url = URL(string: "https://www.google.com/")!
//
//    var body: some View {
//        ZStack {
//            WebView(url: url, state: webViewState)
//
//            if webViewState.isFirstLoading {
//                ProgressView()
//            }
//
//            // 💡 Note: If you want to display an indicator at each page transition.
//            if webViewState.isLoading {
//                ProgressView()
//            }
//        }
//        .toolbar {
//            ToolbarItemGroup(placement: .bottomBar) {
//                Spacer()
//
//                // ✅ Back
//                Button {
//                    webViewState.goBack()
//                } label: {
//                    Image(systemName: "chevron.backward")
//                }
//                .enabled(webViewState.canGoBack)
//
//                // ✅ Forward
//                Button {
//                    webViewState.goForward()
//                } label: {
//                    Image(systemName: "chevron.forward")
//                }
//                .enabled(webViewState.canGoForward)
//            }
//        }
//    }
//}
//
//struct WebView: UIViewRepresentable {
//    typealias UIViewType = WKWebView
//
//    let url: URL
//    let state: WebViewState
//
//    init(url: URL, state: WebViewState) {
//        self.url = url
//        self.state = state
//    }
//
//    func makeCoordinator() -> WebViewCoordinator {
//        .init(state: state)
//    }
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        state.configure(webView: webView)
//
//        let request = URLRequest(url: url)
//        webView.navigationDelegate = context.coordinator
//        webView.load(request)
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {}
//}
//
//final class WebViewState: ObservableObject {
//    typealias Configure = (WKWebView) -> Void
//
//    @Published var isFirstLoading: Bool = true
//    @Published var isLoading: Bool = true
//    @Published var canGoBack: Bool = false
//    @Published var canGoForward: Bool = false
//
//    fileprivate var webView: WKWebView?
//    private let configureWkWebView: Configure?
//
//    init(_ configureWkWebView: Configure? = nil) {
//        self.configureWkWebView = configureWkWebView
//    }
//
//    func goBack() {
//        webView?.goBack()
//    }
//
//    func goForward() {
//        webView?.goForward()
//    }
//
//    fileprivate func configure(webView: WKWebView) {
//        configureWkWebView?(webView)
//        self.webView = webView
//    }
//
//    fileprivate func didStartProvisionalNavigation() {
//        isLoading = true
//
//        updateButtons()
//    }
//
//    fileprivate func didFinish() {
//        isFirstLoading = false
//        isLoading = false
//
//        updateButtons()
//    }
//
//    private func updateButtons() {
//        guard let webView else { return }
//
//        canGoBack = webView.canGoBack
//        canGoForward = webView.canGoForward
//    }
//}
//
//final class WebViewCoordinator: NSObject, WKNavigationDelegate {
//    private var state: WebViewState
//
//    init(state: WebViewState) {
//        self.state = state
//    }
//
//    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
//        state.didStartProvisionalNavigation()
//    }
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        state.didFinish()
//    }
//
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        state.didFinish()
//    }
//}
