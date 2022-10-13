//
//  ExclusiveNegativeNumberView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/09/29.
//

import SwiftUI

struct ExclusiveNegativeNumberView: View {
    @StateObject var viewModel = ENNViewModel()
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("\(viewModel.noneNegativeInt.rawValue)")
                .font(.largeTitle)

            TextField("", text: $text)
                .frame(height: 44)
                .background(.cyan)
                .onSubmit {
                    viewModel.req(int: Int(text)!)
                }
        }
        .padding()
    }

    final class ENNViewModel: ObservableObject {
        @Published var noneNegativeInt: NoneNegativeInt = try! .init(0)

        func req(int: Int) {
            do {
                noneNegativeInt = try .init(int)
            } catch {
                print("Error: ", error.localizedDescription)
            }
        }
    }
}

enum RuleViolation: Error {
    case negativeNumber
}

struct NoneNegativeInt {
    var rawValue: Int

    init(_ int: Int) throws {
        if int < 0 {
            throw RuleViolation.negativeNumber
        }
        self.rawValue = int
    }
}


struct ExclusiveNegativeNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ExclusiveNegativeNumberView()
    }
}
