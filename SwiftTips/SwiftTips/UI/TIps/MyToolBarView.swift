//
//  MyToolBarView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/26.
//

import SwiftUI

struct MyToolBarView: View {
    var body: some View {
        NavigationView {
            Color.red
                .navigationTitle("MyToolbar Example")
                .toolbar { MyToolBarContent() }
        }
    }
}

struct MyToolBarContent: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button("Leading", action: {})
        }

        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Trailing", action: {})
        }

        ToolbarItem(placement: .bottomBar) {
            Button("Bottom", action: {})
        }
    }
}

struct MyToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyToolBarView()
    }
}
