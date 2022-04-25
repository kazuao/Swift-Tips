//
//  SampleUserActivityView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/13.
//

import SwiftUI

struct SampleUserActivityView: View {

    var color: String

    var body: some View {
        Image(color)
            .resizable()
            .userActivity("showColor") { activity in
                // SiriやHandoff、Spotlightなどに使う
                activity.title = color
                activity.isEligibleForSearch = true
                activity.isEligibleForPrediction = true
            }
    }
}
