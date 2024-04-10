//
//  Binding+.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/16.
//

import SwiftUI

extension Binding {
    func map<NewValue>(get: @escaping (Value) -> NewValue, set: @escaping (NewValue) -> Value) -> Binding<NewValue> {
        .init(
            get: { get(wrappedValue) },
            set: { wrappedValue = set($0) }
        )
    }

    /*
     Binding<T?> -> Binding<Bool>
     */
    func isPresent<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        .init(
            get: { self.wrappedValue != nil },
            set: {
                if $0 == false {
                    self.wrappedValue = nil
                }
            }
        )
    }

    /*
     Binding<T?> -> Binding<T>?
     */
    func wrapped<Wrapped>() -> Binding<Wrapped>? where Value == Wrapped? {
        if let value = wrappedValue {
            return .init(get: { value }, set: { wrappedValue = $0 })
        } else {
            return nil
        }
    }
}


