//
//  ErrorAlertView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/16.
//

import SwiftUI

struct ErrorAlertView: View {

    @State private var error: MyError? = nil
    @State private var errorWithMessage: MyError? = nil

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Text("Simple")
                Button("Warning") { error = .warning }
                Button("Fatal") { error = .fatal }
            }

            VStack {
                Text("With message")
                Button("Warning") { errorWithMessage = .warning }
                Button("Fatal") { errorWithMessage = .fatal }
            }
        }
        .alert(error: $error) {}
        .alert(error: $errorWithMessage) { _ in
            // action
            Button("OK") {}
        } message: { error in
            Text(error.helpMessage)
        }
    }
}

enum MyError {
    case warning, fatal

    var helpMessage: String {
        switch self {
        case .warning: return "This is warning."
        case .fatal:   return "This is fatal"
        }
    }
}

extension MyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .warning: return "Warning"
        case .fatal:   return "Fatal"
        }
    }
}

struct ErrorAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorAlertView()
    }
}
