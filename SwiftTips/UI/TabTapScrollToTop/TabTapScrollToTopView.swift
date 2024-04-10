//
//  TabTapScrollToTopView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/15.
//

import SwiftUI

// ref: https://qiita.com/YusukeHosonuma/items/dc986c408e14106caf29
let topID = "TOP"

enum Tab2: String, Identifiable, CaseIterable {
    case first
    case second

    var id: String { rawValue }

    var title: String {
        switch self {
            case .first:  return "First"
            case .second: return "Second"
        }
    }

    @ViewBuilder
    func TabItem() -> some View {
        switch self {
            case .first:  Label(title, systemImage: "1.circle")
            case .second: Label(title, systemImage: "2.circle")
        }
    }
}

struct TabTapScrollToTopView: View {
    @State private var selectedTab: Tab2 = .first

    /* スクロール発火用のトリガー */
    // @State private var tappedTab: Trigger = .init()
    // タブごとにスクロールを管理したい場合は、Triggerを分ける
    @State private var tappedTab: [Tab2: Trigger] = .init(
        uniqueKeysWithValues: Tab2.allCases.map { ($0, .init()) }
    )

    var body: some View {

        // SelectTabがVIew上に定義されている場合は、Bindingで中間取得する
        // 普通に書いたやつ
//        TabView(selection: $selectedTab.willSet {
//            if selectedTab == $0 {
//                // 前回と同じタブが選択された場合
//                // タブが一つの場合
////                tappedTab.fire()
//                // タブが2つの場合
//                tappedTab[selectedTab]?.fire()
//            }
//        }) {
//            Lists()
//                .tabItem {
//                    Label("First", systemImage: "1.circle")
//                }
//                .tag(Tab.first)
//
//            Lists()
//                .tabItem {
//                    Label("Second", systemImage: "2.circle")
//                }
//                .tag(Tab.second)
//        }

        // 共通化したバージョン
        TabContainer(selection: $selectedTab) { tabTappedTwice in
            ForEach(Tab2.allCases) { tab in
                SampleView(
                    title: tab.title,
                    tabTappedTwice: tabTappedTwice[tab]!
                )
                .tabItem(tab.TabItem)
                .tag(tab)
            }
        }
    }
}

/// タブに表示する View
struct SampleView: View {
    var title: String
    var tabTappedTwice: Trigger

    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List {
                    ForEach(items) { item in
                        Text(item.title)
                            .id(items.first?.id == item.id ? topID : nil)
                    }
                }
                .scrollToTop(on: tabTappedTwice, proxy: proxy)
                .listStyle(.plain)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

/// 要素
struct Item: Identifiable {
    var id: Int
    var title: String { "Item \(id)" }

    init(_ number: Int) {
        id = number
    }
}

/// ダミーデータ
private let items: [Item] = (1..<100).map(Item.init)

final class ContentViewModel: ObservableObject {
    // selectedTabがViewModelで実装されている場合は、didSetで披露
    @Published var selectedTab: Tab2 = .first {
        didSet {
            if oldValue == selectedTab {
                // 前回と同じタブが選択された場合
            }
        }
    }
}

extension Binding {
    func willSet(_ handler: @escaping (Value) -> Void)  -> Binding<Value> {
        return .init(
            get: { wrappedValue },
            set: { newValue in
                handler(newValue)
                wrappedValue = newValue
            }
        )
    }
}

// スクロール発火用のトリガー
struct Trigger {
    private(set) var key: Bool = false

    mutating func fire() {
        key.toggle()
    }
}

extension View {
    func onTrigger(of trigger: Trigger?, perform: @escaping () -> Void) -> some View {
        onChange(of: trigger?.key) { _ in
            perform()
        }
    }

    // ターゲットIDが固定ならばモディファイアにできる
    func scrollToTop(on trigger: Trigger?, proxy: ScrollViewProxy) -> some View {
        onTrigger(of: trigger) {
            withAnimation {
                proxy.scrollTo(topID, anchor: .top)
            }
        }
    }
}

// MARK: 共通化しちゃう
struct TabContainer<SelectionValue: Hashable & CaseIterable, Content: View>: View {

    typealias SelectionTab = [SelectionValue: Trigger]

    @Binding var selection: SelectionValue
    @ViewBuilder var content: (SelectionTab) -> Content

    @State private var tabTappedTwice: SelectionTab = .init(
        uniqueKeysWithValues: SelectionValue.allCases.map { ($0, .init()) }
    )

    var body: some View {
        TabView(selection: $selection.willSet {
            if selection == $0 {
                tabTappedTwice[selection]?.fire()
            }
        }) {
            content(tabTappedTwice)
        }
    }
}

struct TabTapScrollToTopView_Previews: PreviewProvider {
    static var previews: some View {
        TabTapScrollToTopView()
    }
}
