//
//  AsyncButtonView.swift
//  SwiftTips
//
//  Created by Kazunori Aoki on 2024/04/12.
//

import SwiftUI

struct AsyncButtonView: View {
    
    @State private var counter: Int = 0
    @State private var trigger: Bool = false
    
    var body: some View {
        VStack {
            Text(counter, format: .number)
                
            AsyncButton(cancellation: trigger) {
                do {
                    try await Task.sleep(for: .seconds(3))
                    counter += 1
                } catch {
                    let _ = print(error.localizedDescription)
                }
            } label: {
                Text("Increment")
            }
            .controlSize(.large)
            .buttonStyle(.borderedProminent)
            
            Button {
                trigger.toggle()
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct AsyncButton<Label: View, Trigger: Equatable>: View {
    var cancellation: Trigger
    var action: () async -> Void
    var label: Label
    
    @State private var task: Task<Void, Never>?
    @State private var isRunning: Bool = false
    
    init(cancellation: Trigger = false, action: @escaping () async -> Void, @ViewBuilder label: () -> Label) {
        self.cancellation = cancellation
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        Button {
            isRunning = true
            
            task = Task {
                await action()
                isRunning = false
            }
        } label: {
            label
        }
        .disabled(isRunning)
        .onChange(of: cancellation) { _, _ in
            task?.cancel()
        }
    }
}

#Preview {
    AsyncButtonView()
}
