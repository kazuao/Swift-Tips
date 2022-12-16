//
//  ContentView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/02/16.
//

import SwiftUI

struct ContentView: View {

#if DEBUG
  @ObservedObject var iO = injectionObserver
#endif

    var body: some View {

        Text("Hello, hot reload!")
            .padding()
            .eraseToAnyView()
    }
}
