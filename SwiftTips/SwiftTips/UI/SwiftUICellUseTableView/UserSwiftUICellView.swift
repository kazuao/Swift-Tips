//
//  UserSwiftUICellView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/08/26.
//

import SwiftUI
import UIKit

struct SFSymbolItem {
    var name: String
}

struct UserInteractionCell: View {
    var item: SFSymbolItem

    // cellの選択状態を取得できる
    var state: UICellConfigurationState

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Image(systemName: item.name)
                .font(state.isSelected ? .title2 : .body)
                .foregroundColor(state.isSelected ? Color(.systemRed) : Color(.label))

            Text(item.name)
                .font(Font.headline.weight(state.isSelected ? .bold : .regular))
                .foregroundColor(state.isSelected ? Color(.systemRed) : Color(.label))

            Spacer()
        }
    }
}

@available(iOS 16.0, *)
final class UserInteractionViewController: UIViewController {

    var collectionView: UICollectionView!

    let dataModel: [SFSymbolItem] = [
        .init(name: "applelogo"),
        .init(name: "iphone"),
        .init(name: "icloud"),
        .init(name: "icloud.fill"),
        .init(name: "car"),
        .init(name: "car.fill"),
        .init(name: "bus"),
        .init(name: "bus.fill"),
        .init(name: "flame"),
        .init(name: "flame.fill"),
        .init(name: "bolt"),
        .init(name: "bolt.fill")
    ]

    private var userInteractionCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, SFSymbolItem>!

    override func viewDidLoad() {
        super.viewDidLoad()

        userInteractionCellRegistration = .init { [unowned self] cell, indexPath, item in
            cell.contentConfiguration = createHostingConfiguration(for: item, with: .init(traitCollection: .current))
        }

        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.dataSource = self
        view = collectionView
    }

    private func createHostingConfiguration(for item: SFSymbolItem,
                                            with state: UICellConfigurationState) -> UIHostingConfiguration<some View, EmptyView> {
        return UIHostingConfiguration {
            UserInteractionCell(item: item, state: state)
            // スワイプ処理
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {

                    Button("SHARE") { [unowned self] in
                        showAlert(title: "Share", message: item.name)
                    }
                    .tint(.green)

                    Button(role: .destructive) { [unowned self] in
                        showAlert(title: "Delete", message: item.name)
                    } label: {
                        Label("", systemImage: "trashs")
                    }
                    .tint(.yellow)
                }
        }
    }

    private func showAlert(title: String, message: String) {
        
    }
}

@available(iOS 16.0, *)
extension UserInteractionViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataModel[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: userInteractionCellRegistration,
                                                                for: indexPath,
                                                                item: item)

        cell.configurationUpdateHandler = { [unowned self] cell, state in
            cell.contentConfiguration = createHostingConfiguration(for: item, with: state)

            // background configuration
            var newBGConfiguration = UIBackgroundConfiguration.listGroupedCell()
            newBGConfiguration.backgroundColor = .systemBackground
            cell.backgroundConfiguration = newBGConfiguration
        }

        return cell
    }
}

@available(iOS 16.0, *)
extension UserInteractionViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}
