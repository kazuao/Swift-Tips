//
//  InjectionObserver.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/02.
//

import Combine
import SwiftUI

#if DEBUG

public let injectionObserver = InjectionObserver()

public final class InjectionObserver: ObservableObject {
    @Published var injectionNumber = 0
    private var cancellable: AnyCancellable? = nil
    let publisher: PassthroughSubject<Void, Never> = .init()

    init() {
        cancellable = NotificationCenter.default
            .publisher(for: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"))
            .sink(receiveValue: { [weak self] change in
                self?.injectionNumber += 1
                self?.publisher.send()
            })
    }
}

extension View {
    public func eraseToAnyView() -> some View {
        return AnyView(self)
    }

    public func onInjection(bumpState: @escaping () -> Void) -> some View {
        return self
            .onReceive(injectionObserver.publisher, perform: bumpState)
            .eraseToAnyView()
    }
}


#else
extension View {
    public func eraseToAnyView() -> some View { return self }
    public func onInjection(bumpState: @escaping () -> Void) -> some View { return self }
}

#endif
