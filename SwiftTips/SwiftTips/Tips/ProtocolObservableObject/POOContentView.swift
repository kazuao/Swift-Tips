//
//  POOContentView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/05/02.
//

import SwiftUI

struct POOContentView<ViewModel: POOViewModel>: View {

    // EnvironmentObjectでもいける
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        Button {
            viewModel.update()
        } label: {
            Text(viewModel.name)
        }
    }
}

struct POOContentView_Previews: PreviewProvider {
    static var previews: some View {
        POOContentView(viewModel: PreviewPOOViewModelImpl())
    }
}
