//
//  POOViewModel.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/02.
//

import Foundation

@MainActor
protocol POOViewModel: ObservableObject {
    var name: String { get set }

    func update()
}


@MainActor
final class POOViewModelImpl: POOViewModel {
    @Published var name: String = Date.now.description

    func update() {
        Task {
            let (data, _) = try await URLSession.shared.data(from: .init(string: "https://httpbin.org/get")!)

            name = String(data: data, encoding: .utf8) ?? "nil"
        }
    }
}

class PreviewPOOViewModelImpl: POOViewModel {
    @Published var name: String = Date.now.description

    func update() {
        name = Date.now.description
    }
}
