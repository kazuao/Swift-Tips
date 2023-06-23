//
//  HideAnimationView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/04/06.
//

import SwiftUI

struct HideAnimationView: View {

    @State private var isPresented: Bool = false

    var body: some View {
        VStack {
            Button {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    isPresented = true
                }
            } label: {
                Text("Full screen covern")
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            FullScreenView()
        }
    }
}

struct FullScreenView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            Button {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    dismiss()
                }
            } label: {
                Text("Close")
                    .foregroundColor(.white)
            }
        }
    }
}

struct HideAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        HideAnimationView()
    }
}
