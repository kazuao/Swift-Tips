//
//  RequestReviewView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/09.
//

import SwiftUI
import StoreKit

struct RequestReviewView: View {

    @Environment(\.requestReview) var requestReview

    var body: some View {
        Button("Request Review") {
            requestReview()
        }
    }
}

struct RequestReviewView_Previews: PreviewProvider {
    static var previews: some View {
        RequestReviewView()
    }
}
