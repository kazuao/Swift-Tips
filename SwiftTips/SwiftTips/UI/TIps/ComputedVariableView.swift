//
//  ComputedVariableView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/04/26.
//

import SwiftUI

struct ComputedVariableView: View {

    @State private var showResults: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, User!")

                if showResults {
                    results
                } else {
                    noData
                }
            }
        }
    }

    // ViewをComputed Variableに書き出す
    private var results: some View {
        VStack {
            Text("Results")
                .font(.title)

            Image("results")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
        }
    }

    private var noData: some View {
        VStack {
            Text("There is no data yes!")
                .font(.title)

            Text("Go out and collect some data.")

            Button("Start", action: collectData)
        }
    }
    private func collectData() {}
}
