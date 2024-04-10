//
//  FileImporter.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/09.
//

import SwiftUI
import QuickLook

struct FileImporter: View {

    @State private var pickFile: Bool = false
    @State private var fileURL: URL?

    var body: some View {
        Button("Pick File") {
            pickFile.toggle()
        }
        .fileImporter(isPresented: $pickFile, allowedContentTypes: [.mp3, .pdf]) { result in
            switch result {
            case .success(let url):
                fileURL = url.absoluteURL
                print(fileURL)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
        .quickLookPreview($fileURL)
    }
}

struct FileImporter_Previews: PreviewProvider {
    static var previews: some View {
        FileImporter()
    }
}
