//
//  SortedKeyPathComparator.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/07/21.
//

import Foundation

struct Ingredient {
    var name: String
    var sortOrder: Int
}

final class SortedKeyPathComparator {

    let ingredients: [Ingredient] = [
        .init(name: "cheese", sortOrder: 2),
        .init(name: "potato", sortOrder: 1),
        .init(name: "cream", sortOrder: 3),
    ]

    func sortedUsingKeyPath() {

        // MARK: 通常なら
        let _ = ingredients
            .sorted { ingredient1, ingredient2 in
                ingredient1.sortOrder < ingredient2.sortOrder
            }

        // MARK: Using key path
        let _ = ingredients
            .sorted(using: KeyPathComparator(\.sortOrder))
//            .sorted(using: KeyPathComparator(\.sortOrder, order: .reverse)) // using reverse
    }
}
