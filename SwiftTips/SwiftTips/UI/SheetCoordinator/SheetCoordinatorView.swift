//
//  SheetCoordinatorView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/02.
//

import SwiftUI

// MARK: Use Sheet Coordinator
struct SheetCoordinatorView: View {

    @StateObject var sheetCoordinator = SheetCoordinator<ArticleSheet>()

    var body: some View {
        VStack {
            Button("Add Article") {
                sheetCoordinator.presentSheet(.addArticle)
            }
            Button("Edit Article") {
                sheetCoordinator.presentSheet(.editArticle)
            }
            Button("Article Category") {
                sheetCoordinator.presentSheet(.selectArticleCategory)
            }
        }
        .sheetCoordinating(coordinator: sheetCoordinator)
        .padding()
        .frame(width: 400, height: 300)
    }
}

// MARK: Sheet Enum Protocol
protocol SheetEnum: Identifiable {
    associatedtype Body: View

    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> Body
}

// MARK: Example Sheet Enum
enum ArticleSheet: String, Identifiable, SheetEnum {
    case addArticle, editArticle, selectArticleCategory

    var id: String { rawValue }

    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> some View {
        switch self {
        case .addArticle:
            AddArticleView()
        case .editArticle:
            EditArticleView()
        case .selectArticleCategory:
            SelectArticleCategoryView(sheetCoordinator: coordinator)
        }
    }
}

// MARK: Example View
struct AddArticleView: View {
    var body: some View { ZStack {} }
}

struct EditArticleView: View {
    var body: some View { ZStack {} }
}

struct SelectArticleCategoryView: View {
    @StateObject var sheetCoordinator: SheetCoordinator<ArticleSheet>
    var body: some View { ZStack {} }
}

// MARK: Coordinator
final class SheetCoordinator<Sheet: SheetEnum>: ObservableObject {
    @Published var currentSheet: Sheet?
    private var sheetStack: [Sheet] = []

    @MainActor
    func presentSheet(_ sheet: Sheet) {
        sheetStack.append(sheet)

        if sheetStack.count == 1 {
            currentSheet = sheet
        }
    }

    @MainActor
    func sheetDismissed() {
        sheetStack.removeFirst()

        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}

// MARK: Coordinator View Modifier
struct SheetCoordinating<Sheet: SheetEnum>: ViewModifier {
    @StateObject var coordinator: SheetCoordinator<Sheet>

    func body(content: Content) -> some View {
        content
            .sheet(item: $coordinator.currentSheet) {
                coordinator.sheetDismissed()
            } content: { sheet in
                sheet.view(coordinator: coordinator)
            }

    }
}

extension View {
    func sheetCoordinating<Sheet: SheetEnum>(coordinator: SheetCoordinator<Sheet>) -> some View {
        return modifier(SheetCoordinating(coordinator: coordinator))
    }
}

struct SheetCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        SheetCoordinatorView()
    }
}
