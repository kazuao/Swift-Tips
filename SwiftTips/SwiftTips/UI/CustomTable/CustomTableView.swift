//
//  CustomTableView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/08.
//

import SwiftUI

struct CustomTableView: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var isCompact: Bool {
        horizontalSizeClass == .compact
    }

    @StateObject var store: WorldStore
    @State private var selected: Set<Country.ID> = .init()
    @State private var sortOrder = [KeyPathComparator(\Country.name)]

    var body: some View {
        VStack {
            Table(store.countries, selection: $selected, sortOrder: $sortOrder) {
                TableColumn("Name", value: \.name)
                TableColumn("Capital", value: \.capital)

                TableColumn("Continent") { country in
                    Text(country.continent)
                        .fontWeight(.bold)
                }

                TableColumn("Name", value: \.name) { country in
                    VStack(alignment: .leading) {
                        Text(country.name)
                        if isCompact {
                            Text(country.capital)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            Table(of: Country.self) {
                TableColumn("Name", value: \.name)
                TableColumn("Capital", value: \.capital)
                TableColumn("Continent", value: \.continent)
            } rows: {
                ForEach(Country.countries) { country in
                    TableRow(country)
                }
            }
        }
        //        .onChange(of: sortOrder) { store.sortOrder = $0 }
    }
}

struct CustomTableView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTableView(store: WorldStore())
    }
}

class WorldStore: ObservableObject {
    @Published var countries: [Country] = Country.countries
}

struct Country: Identifiable {
    var id: Int
    var name: String
    var capital: String
    var continent: String
    var currency: String
    var area: Double
    var population: Int
    var visited: Bool
}

extension Country {
    static let countries: [Country] = [
        .init(id: 1, name: "1", capital: "a", continent: "1", currency: "1", area: 1, population: 1, visited: true),
        .init(id: 2, name: "2", capital: "b", continent: "2", currency: "2", area: 2, population: 2, visited: false)
    ]
}
