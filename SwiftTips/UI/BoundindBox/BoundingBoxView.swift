//
//  BoundingBoxView.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/12.
//

import SwiftUI
import CoreGraphics

// https://dev.classmethod.jp/articles/swiftui-boundingbox/
struct BoundingBoxView: View {

    @State private var isEditing = true
    @State private var width: CGFloat = 150
    @State private var height: CGFloat = 150
    @State private var location: CGPoint = CGPoint(x: 150, y: 100)
    @State private var formType: EditFormType = .freeForm

    var body: some View {
        VStack {
            Image(systemName: "nose")
                .resizable()
                .boundingBox(formType: formType,
                             isEditing: isEditing,
                             editingWidth: $width,
                             editingHeight: $height,
                             position: $location)

            HStack {
                Button {
                    formType = formType == .freeForm ? .uniform : .freeForm
                } label: {
                    Text(formType.rawValue)
                }

                Button {
                    isEditing.toggle()
                } label: {
                    Text("is editing")
                }
            }
        }
    }
}

struct BoundingBox<Content: View>: View {
    @Binding var editingWidth: CGFloat
    @Binding var editingHeight: CGFloat
    @Binding var editingPosition: CGPoint

    let formType: EditFormType
    let isEditing: Bool
    let content: Content

    private let minScalingWidth: CGFloat = 10
    private let minScalingHeight: CGFloat = 10

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                editingPosition = value.location
            }
    }

    init(editingWidth: Binding<CGFloat>,
         editingHeight: Binding<CGFloat>,
         editingPosition: Binding<CGPoint>,
         formType: EditFormType,
         isEditing: Bool,
         @ViewBuilder content: () -> Content) {
        _editingWidth = editingWidth
        _editingHeight = editingHeight
        _editingPosition = editingPosition
        self.formType = formType
        self.isEditing = isEditing
        self.content = content()
    }

    var body: some View {
        ZStack {
            if isEditing {
                content
                    .overlay {
                        MovingDashFramedRectangle()

                        EditPointsFramedRectangle(width: editingWidth, height: editingHeight) { value in
                            switch formType {
                            case .freeForm:
                                guard editingWidth + value.scaleSize.width > minScalingWidth,
                                      editingHeight + value.scaleSize.height > minScalingHeight else { return }

                                editingWidth += value.scaleSize.width
                                editingHeight += value.scaleSize.height

                            case .uniform:
                                guard editingWidth + value.scaleValue > minScalingWidth,
                                      editingHeight + value.scaleValue > minScalingHeight else { return }

                                editingWidth += value.scaleValue
                                editingHeight += value.scaleValue
                            }
                        }
                    }
                    .frame(width: editingWidth, height: editingHeight)
                    .position(editingPosition)
                    .gesture(dragGesture)
            } else {
                content
                    .frame(width: editingWidth, height: editingHeight)
                    .position(editingPosition)
            }
        }
    }
}

struct MovingDashFramedRectangle: View {
    @State private var dashPhase: CGFloat = 0
    @State private var timerCount: CGFloat = 0
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Rectangle()
            .stroke(style: .init(dash: [6, 6], dashPhase: dashPhase))
            .onReceive(timer) { _ in
                timerCount = timerCount > 10 ? 0 : timerCount + 1
                dashPhase = timerCount
            }
    }
}

struct EditPointMark: View {
    private let editPointFrame = EditPointFrame()
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .shadow(radius: 1)
                .frame(width: editPointFrame.outCircleDiameter,
                       height: editPointFrame.outCircleDiameter)
            
            Circle()
                .foregroundColor(.accentColor)
                .frame(width: editPointFrame.innerCircleDiameter,
                       height: editPointFrame.innerCircleDiameter)
        }
    }
}

struct EditPoint: View {
    let editingWidth: CGFloat
    let editingHeight: CGFloat
    let position: EditPointPosition
    let scalingAction: (_ value: EditPointScaling.Value) -> Void

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let editPointScaling = EditPointScaling(position: position,
                                                        dragGestureTranslation: value.translation)
                scalingAction(editPointScaling.value)
            }
    }

    var body: some View {
        ZStack {
            EditPointMark()
                .gesture(dragGesture)
                .offset(x: position.offset.x, y: position.offset.y)
        }
        .frame(width: editingWidth, height: editingHeight, alignment: position.alignment)
    }
}

struct EditPointsFramedRectangle: View {
    let width: CGFloat
    let height: CGFloat
    let scaleChangeAction: (_ value: EditPointScaling.Value) -> Void

    var body: some View {
        ZStack {
            ForEach(EditPointPosition.allCases) { position in
                EditPoint(editingWidth: width,
                          editingHeight: height,
                          position: position) { value in
                    scaleChangeAction(value)
                }
            }
        }
    }
}

struct EditPointScaling {
    // 編集点
    let position: EditPointPosition
    // ドラッグジェスチャのtranslation
    let dragGestureTranslation: CGSize

    // translationを加工した編集店の拡大縮小の値
    var value: EditPointScaling.Value {
        return .init(scaleValue: self.scaleValue, scaleSize: self.scaleSize)
    }

    // ドラッグされた編集点によって、どのくらいサイズが変更可の値
    private var scaleSize: CGSize {

        switch position {
        case .topLeft:
            return CGSize(width: dragGestureTranslation.width * -1,
                          height: dragGestureTranslation.height * -1)
        case .topCenter:
            return CGSize(width: 0,
                          height: dragGestureTranslation.height * -1)
        case .topRight:
            return CGSize(width: dragGestureTranslation.width,
                          height: dragGestureTranslation.height * -1)
        case .middleLeft:
            return CGSize(width: dragGestureTranslation.width * -1,
                          height: 0)
        case .middleRight:
            return CGSize(width: dragGestureTranslation.width,
                          height: 0)
        case .bottomLeft:
            return CGSize(width: dragGestureTranslation.width * -1,
                          height: dragGestureTranslation.height)
        case .bottomCenter:
            return CGSize(width: 0,
                          height: dragGestureTranslation.height)
        case .bottomRight:
            return CGSize(width: dragGestureTranslation.width,
                          height: dragGestureTranslation.height)
        }
    }

    // ドラッグされた編集店によって、どのくらい縦／横スケールしたかの値
    private var scaleValue: CGFloat {
        switch position {
        case .topLeft, .topRight, .middleLeft, .middleRight, .bottomLeft, .bottomRight:
            return scaleSize.width
        case .topCenter, .bottomCenter:
            return scaleSize.height
        }
    }

    struct Value {
        let scaleValue: CGFloat
        let scaleSize: CGSize
    }
}

enum EditPointPosition: String, CaseIterable, Identifiable {
    case topLeft
    case topCenter
    case topRight
    case middleLeft
    case middleRight
    case bottomLeft
    case bottomCenter
    case bottomRight

    var id: String {
        return self.rawValue
    }
    
    var alignment: Alignment {
        switch self {
        case .topLeft:
            return .topLeading
        case .topCenter:
            return .top
        case .topRight:
            return .topTrailing
        case .middleLeft:
            return .leading
        case .middleRight:
            return .trailing
        case .bottomLeft:
            return .bottomLeading
        case .bottomCenter:
            return .bottom
        case .bottomRight:
            return .bottomTrailing
        }
    }
    
    var offset: Offset {
        
        let editPointFrame = EditPointFrame()
        let radius = editPointFrame.outerCircleRadius
        
        switch self {
        case .topLeft:
            return Offset(x: -radius, y: -radius)
        case .topCenter:
            return Offset(x: 0, y: -radius)
        case .topRight:
            return Offset(x: radius, y: -radius)
        case .middleLeft:
            return Offset(x: -radius, y: 0)
        case .middleRight:
            return Offset(x: radius, y: 0)
        case .bottomLeft:
            return Offset(x: -radius, y: radius)
        case .bottomCenter:
            return Offset(x: 0, y: radius)
        case .bottomRight:
            return Offset(x: radius, y: radius)
        }
    }
    
    struct Offset {
        let x: CGFloat
        let y: CGFloat
    }
}

enum EditFormType: String, CaseIterable, Identifiable {
    case freeForm = "Free form"
    case uniform = "Uniform"

    var id: String { rawValue }
}

final class EditPointFrame {
    let outCircleDiameter: CGFloat = 10
    let innerCircleDiameter: CGFloat = 6
    
    var outerCircleRadius: CGFloat {
        return outCircleDiameter / 2
    }
}

extension View {
    func boundingBox(formType: EditFormType,
                     isEditing: Bool,
                     editingWidth: Binding<CGFloat>,
                     editingHeight: Binding<CGFloat>,
                     position: Binding<CGPoint>) -> some View {
        self.modifier(BoundingBoxModifier(formType: formType,
                                          isEditing: isEditing,
                                          width: editingWidth,
                                          height: editingHeight,
                                          position: position)
        )
    }
}

struct BoundingBoxModifier: ViewModifier {
    let formType: EditFormType
    let isEditing: Bool
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    @Binding var position: CGPoint

    func body(content: Content) -> some View {
        BoundingBox(editingWidth: $width,
                    editingHeight: $height,
                    editingPosition: $position,
                    formType: formType,
                    isEditing: isEditing) {
            content
        }
    }
}

struct BoundingBoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoundingBoxView()

        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 10, height: 10)
    }
}
