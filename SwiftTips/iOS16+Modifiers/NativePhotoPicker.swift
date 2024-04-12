//
//  NativePhotoPicker.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2023/06/23.
//

import SwiftUI
import PhotosUI
import AVKit

struct NativePhotoPicker: View {

    @State private var showVideoPicker: Bool = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var isVideoProcessing: Bool = false

    @State private var pickedVideoURL: URL?

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    if let pickedVideoURL {
                        VideoPlayer(player: .init(url: pickedVideoURL))
                    } else {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                    }

                    if isVideoProcessing {
                        ProgressView()
                    }
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 15))

                HStack(spacing: 15) {
                    Button("Pick Video") {
                        showVideoPicker.toggle()
                    }

                    Button("Remove Picked Video") {
                        deleteFile()
                    }
                }
                .padding(.top, 5)
            }
            .navigationTitle("Native Video Picker")
            .padding()
            .photosPicker(isPresented: $showVideoPicker, selection: $selectedItem, matching: .videos)
            .onChange(of: selectedItem) { _, newValue in
                if let newValue {
                    Task {
                        do {
                            isVideoProcessing = true
                            let pickedMovie = try await newValue.loadTransferable(type: VideoPickerTransferable.self)
                            isVideoProcessing = false
                            pickedVideoURL = pickedMovie?.videoURL
                        } catch {
                            let _ = print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }

    func deleteFile() {
        do {
            if let pickedVideoURL {
                try FileManager.default.removeItem(at: pickedVideoURL)
                self.pickedVideoURL = nil
            }
        } catch {
            let _ = print(error.localizedDescription)
        }
    }
}

struct VideoPickerTransferable: Transferable {
    let videoURL: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { exportingFile in
            return .init(exportingFile.videoURL)

        } importing: { receivedTransferredFile in
            let originalFile = receivedTransferredFile.file
            let copiedFile = URL.documentsDirectory.appending(path: "videoPicker.mov")

            if FileManager.default.fileExists(atPath: copiedFile.path()) {
                try FileManager.default.removeItem(at: copiedFile)
            }

            try FileManager.default.copyItem(at: originalFile, to: copiedFile)
            return .init(videoURL: copiedFile)
        }
    }
}

struct NativePhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        NativePhotoPicker()
    }
}

