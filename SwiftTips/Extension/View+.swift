//
//  View+.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/16.
//

import SwiftUI

extension View {

    func hideKeyboard() {
        UIApplication.hideKeyboard()
    }

    func enabled(_ enabled: Bool) -> some View {
        disabled(enabled == false)
    }

    func frame(size: CGSize?) -> some View {
        frame(width: size?.width, height: size?.height)
    }

    func extend<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View {
        transform(self)
    }

    /// 任意のタイミングでモディファイアを適用する
    @ViewBuilder
    func when<Content: View>(_ condition: Bool, @ViewBuilder transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }

    /// 任意のOptinalの値が格納されたときにモディファイアを適用する
    @ViewBuilder
    func wenLet<V, Content: View>(optional: V?, @ViewBuilder transform: (Self, V) -> Content) -> some View {
        if let value = optional {
            transform(self, value)
        } else {
            self
        }
    }

    func onChangeSize(perform: @escaping (CGSize) -> Void) -> some View {
        sizePreference()
            .onChangeSizePreference(perform: perform)
    }

    func sizePreference() -> some View {
        background(
            GeometryReader { local in
                Color.clear
                    .preference(key: SizeKey.self, value: local.size)
            }
        )
    }

    func onChangeSizePreference(perform: @escaping (CGSize) -> Void) -> some View {
        onPreferenceChange(SizeKey.self) { size in
            if let size = size {
                perform(size)
            }
        }
    }
}

extension View {

    /// 任意のボーダーを付ける
    func border(_ color: Color, width: CGFloat = 1, edge: Edge.Set) -> some View {
        overlay(
            VStack(spacing: 0) {
                if edge == .all || edge == .vertical || edge == .top {
                    color.frame(height: width)
                }
                Spacer()
                if edge == .all || edge == .vertical || edge == .bottom {
                    color.frame(height: width)
                }
            }
        )
        .overlay(
            HStack(spacing: 0) {
                if edge == .all || edge == .horizontal || edge == .leading {
                    color.frame(width: width)
                }
                Spacer()
                if edge == .all || edge == .horizontal || edge == .trailing {
                    color.frame(width: width)
                }
            }
        )
    }
}

// MARK: +Alert
extension View {
    func alert<E: LocalizedError, A: View>(error: Binding<E?>, @ViewBuilder actions: () -> A) -> some View {
        alert(isPresented: error.isPresent(), error: error.wrappedValue, actions: actions)
    }

    func alert<E: LocalizedError, A: View, M: View>(
        error: Binding<E?>,
        @ViewBuilder actions: (E) -> A,
        @ViewBuilder message: (E) -> M
    ) -> some View {
        alert(isPresented: error.isPresent(), error: error.wrappedValue, actions: actions, message: message)
    }
}

// MARK: +Debug
extension View {

    /*
     Text("\(number)")
        .debug {
            print("number: \(number)")
        }
     */
    func debug(_ handler: () -> Void) -> Self {
        handler()
        return self
    }

    /*
     Text("\(number)")
        .print("number: \(number)")
     */
    func print(_ target: Any) -> Self {
        debug {
            Swift.print(target)
        }
    }

    /*
     @State var number: Int = 42

     var body: some View {
         Text("\(number)")
             .printOnChange("number: ") { number } // 💡 Print "number: 42" when `number is changed.
     }
     */
    func printOnChange<Value: Equatable>(_ label: String = "", value: () -> Value) -> some View {
        onChange(of: value()) { _, newValue in
            Swift.print("\(label)\(newValue)")
        }
    }
}

private struct BoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>?

    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}

private struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize?

    static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
        value = nextValue()
    }
}
