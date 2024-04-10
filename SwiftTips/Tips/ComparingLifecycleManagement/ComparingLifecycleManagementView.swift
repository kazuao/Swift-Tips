//
//  ComparingLifecycleManagementView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/06.
//

import SwiftUI
import Combine

struct CLMView: View {

    @State private var isPortraitFromPublisher: Bool = false
    @State private var isPortraitFromSequence: Bool = false

    private let viewModel = ExampleViewModel()

    var body: some View {
        VStack {
            Text("Portrait from publisher: \(isPortraitFromPublisher ? "yes" : "no")")
            Text("Portrait from sequence: \(isPortraitFromSequence ? "yes" : "no")")
        }
        .task {
            let sequence = await viewModel.notificationCenterSequence()
            for await orientation in sequence {
                isPortraitFromSequence = orientation == .portrait
            }
        }
        .onReceive(viewModel.notificationCenterPublisher()) { orientation in
            isPortraitFromPublisher = orientation == .portrait
        }
    }
}

fileprivate final class ExampleViewModel {

    func notificationCenterPublisher() -> AnyPublisher<UIDeviceOrientation, Never> {
        return NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .map { _ in UIDevice.current.orientation }
            .eraseToAnyPublisher()
    }

    func notificationCenterSequence() async -> AsyncMapSequence<NotificationCenter.Notifications, UIDeviceOrientation> {
        return await NotificationCenter.default
            .notifications(named: UIDevice.orientationDidChangeNotification)
            .map { _ in await UIDevice.current.orientation }
    }
}

struct CLMView2: View {

    @State private var showExampleView: Bool = false

    var body: some View {
        Button("Show Example") {
            showExampleView = true
        }
        .sheet(isPresented: $showExampleView) {
            SheetCLMView(viewModel: ExampleViewModel2())
        }
    }
}

fileprivate struct SheetCLMView: View {
    @ObservedObject var viewModel: ExampleViewModel2
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text("Portrait from publisher: \(viewModel.isPortraitFromPublisher ? "yes" : "no")")
                Text("Portrait from sequence: \(viewModel.isPortraitFromSequence ? "yes" : "no")")
            }

            Button("Dismiss") {
                dismiss()
            }
        }
        .onAppear {
            viewModel.setup()
        }
    }
}

@MainActor
fileprivate final class ExampleViewModel2: ObservableObject {

    @Published var isPortraitFromPublisher: Bool = false
    @Published var isPortraitFromSequence: Bool = false

    private var cancellables = Set<AnyCancellable>()

    deinit {
        print("Deinit")
    }

    func setup() {
        notificationCenterPublisher()
            .map { $0 == .portrait }
            .handleEvents(receiveOutput: { _ in print("Subscription received value") })
            .assign(to: &$isPortraitFromPublisher)

        Task { [weak self] in
            guard let sequence = await self?.notificationCenterSequence() else { return }

            for await orientation in sequence {
                // 2. selfを確認し、存在しない場合は抜ける方法（おすすめ）
                // for await in ループの中で確認すること
                guard let self else { return }

                print("Sequence received value")
                self.isPortraitFromSequence = orientation == .portrait

                // 1. askがキャンセルされていたら抜ける方法
//                if Task.isCancelled { break }
            }
        }
        .store(in: &cancellables)
    }

    func notificationCenterPublisher() -> AnyPublisher<UIDeviceOrientation, Never> {
        return NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .map { _ in UIDevice.current.orientation }
            .eraseToAnyPublisher()
    }

    func notificationCenterSequence() async -> AsyncMapSequence<NotificationCenter.Notifications, UIDeviceOrientation> {
        return NotificationCenter.default
            .notifications(named: UIDevice.orientationDidChangeNotification)
            .map { _ in await UIDevice.current.orientation }
    }
}

extension Task {
    func store(in cancellables: inout Set<AnyCancellable>) {
        asCancellables().store(in: &cancellables)
    }

    func asCancellables() -> AnyCancellable {
        .init { self.cancel() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
