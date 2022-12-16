//
//  ActivityView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/16.
//

import SwiftUI

struct ActivityViewContentView: View {
    @State private var isPresent: Bool = false
    var body: some View {
        Image(systemName: "square.and.arrow.up")
            .sheet(isPresented: $isPresent) {
                ActivityView(activityItems: [URL(string: "https://www.google.com/")!])
            }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    private let activityItems: [Any]
    private let applicationActivities: [UIActivity]?
    
    init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
    }
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        .init(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        Image(systemName: "square.and.arrow.up")
            .sheet(isPresented: .constant(true)) {
                ActivityView(activityItems: [URL(string: "https://www.google.com/")!])
            }
    }
}
