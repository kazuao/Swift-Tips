//
//  FileExporter.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/03/09.
//

import SwiftUI
import UniformTypeIdentifiers

struct FileExporterView: View {

    @State private var exportAssetImage: Bool = false
    @State private var exportImage: PNGDocument?

    var body: some View {
        Button("Export Image") {
            if let image = FileImage(named: "Photo1") {
                exportImage = PNGDocument(image: image)
                exportAssetImage.toggle()
            }
        }
        .fileExporter(isPresented: $exportAssetImage, document: exportImage, contentType: .png) { result in
            switch result {
            case .success(_):
                Swift.print("Saved success:")
            case .failure(let failure):
                let _ = print(failure)
            }
        }
    }
}

// MARK: Creating Document File for saving Image as PNG File
#if os(iOS)
typealias FileImage = UIImage
#else
typealias FileImage = NSImage
#endif
struct PNGDocument: FileDocument {
    var image: FileImage
    init(image: FileImage) {
        self.image = image
    }

    static var readableContentTypes: [UTType] {[.png]}

    init(configuration: ReadConfiguration) throws {
        guard let pngDate = configuration.file.regularFileContents,
              let pngImage = FileImage(data: pngDate) else {
            throw CocoaError(.fileReadUnknown)
        }

        image = pngImage
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        #if os(iOS)
        guard let pngData = image.pngData() else { return .init() }
        #else
        /** Signing & Capabilities > File Access Type > User Selected File > Read/Write */
        guard let pngData = image.tiffRepresentation else { return .init() }
        #endif

        return .init(regularFileWithContents: pngData)
    }
}

struct FileExporter_Previews: PreviewProvider {
    static var previews: some View {
        FileExporterView()
    }
}
