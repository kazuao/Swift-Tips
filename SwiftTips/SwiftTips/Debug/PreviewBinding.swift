//
//  PreviewBinding.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/28.
//

import SwiftUI

extension Binding {

    /*
     SwiftUI Previewの引数に使う

     - usage
     DemoView(value: .mock(SampleData))
     */
    static func mock(_ value: Value) -> Self {
        var value = value
        return Binding(
            get: { value },
            set: { value = $0 }
        )
    }
}

/*
 PreviewのStateを利用するため

 - Usage:
     struct TodoRowView_Previews_withGenericWrapper: PreviewProvider {
       static var previews: some View {
         StatefulPreviewContainer(Todo.sampple) { binding in
           TodoRowView(todo: binding)
         }
       }
     }
 */
struct StatefulPreviewContainer<Value, Content: View>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}

//struct StatefulPreviewContainer<Value, Content: View>: View {
//  @State var value: Value
//  var content: (Binding<Value>) -> Content
//
//  var body: some View {
//    content($value)
//  }
//
//  init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
//    self._value = State(wrappedValue: value)
//    self.content = content
//  }
//}
