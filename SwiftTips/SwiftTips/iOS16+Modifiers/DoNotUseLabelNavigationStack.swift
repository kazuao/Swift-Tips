//
//  DoNotUseLabelNavigationStack.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/09.
//

import SwiftUI

struct DoNotUseLabelNavigationStack: View {
    @State private var pushNewView: Bool = false

    var body: some View {
        NavigationStack {
            Button("Push View") {
                pushNewView.toggle()
            }
            .navigationDestination(isPresented: $pushNewView) {
                Text("New View")
            }
        }
    }
}

struct DoNotUseLabelNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        DoNotUseLabelNavigationStack()
    }
}
