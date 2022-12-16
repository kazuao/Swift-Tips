//
//  NavigationStackTips.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/11/14.
//

import SwiftUI

enum NavigationPage: Hashable, Codable {
    case person(name: String)
    case plant(name: String)
}

extension [NavigationPage]: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data) else { return nil }

        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8) else { return "[]" }

        return result
    }
}


struct NavigationStackTips: View {
    @AppStorage("navigationPath") private var navigationPath: [NavigationPage] = []

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                NavigationLink("Flo", value: NavigationPage.person(name: "Flo"))
                NavigationLink("Tree", value: NavigationPage.plant(name: "Tree"))
            }
            .navigationDestination(for: NavigationPage.self) { page in
                switch page {
                case .person(let name):
                    Text("Person: \(name)")
                case .plant(let name):
                    Text("Plant: \(name)")
                }
            }
        }
    }
}

struct NavigationStackTips_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackTips()
    }
}
