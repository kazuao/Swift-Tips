//
//  VariableButtons.swift
//  SwiftTips
//
//  Created by kazunori.aoki on 2022/12/12.
//

import SwiftUI

// https://zenn.dev/juginon/articles/a5acd449f70d61
struct VariableButtons: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 100) {
                SkeuomorphismButton()
                FlatDesignButton()
                NeumorphismButton()
                GrassmorphismButton()
                ClaymorphismButton()
            }
        }
    }
}

struct SkeuomorphismButton: View {
    let gradientView = LinearGradient(gradient: .init(colors: [
        .init(red: 1, green: 0, blue: 0, opacity: 0.55),
        .init(red: 1, green: 0, blue: 0, opacity: 0.65)
    ]), startPoint: .top, endPoint: .center)

    var body: some View {
        Button {} label: {
            Text("Skeuomorphism Button")
                .font(.system(size: 25))
                .fontWeight(.bold)
                .shadow(color: .black, radius: 0, x: 0, y: -1)
                .foregroundColor(.white)
                .padding()
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .foregroundColor(.white)

                        RoundedRectangle(cornerRadius: 16)
                            .foregroundStyle(gradientView)

                        RoundedRectangle(cornerRadius: 16)
                            .trim(from: 0, to: 0.5)
                            .foregroundColor(.red)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 4)
                        .shadow(color: .black, radius: 0, x: 0, y: -1)
                )
        }
    }
}

struct FlatDesignButton: View {
    var body: some View {
        Button {} label: {
            Text("Flat Design Button")
                .font(.system(size: 25))
                .fontWeight(.ultraLight)
                .foregroundColor(.blue)
                .padding()
                .border(.blue, width: 0.5)
        }
    }
}

struct NeumorphismButton: View {
    let bgColor = Color(red: 0.92, green: 0.93, blue: 0.94)
    let grayColor = Color(white: 0.8, opacity: 1)

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            Button {} label: {
                Text("Newmorphism Button")
                    .font(.system(size: 25, weight: .semibold, design: .rounded))
                    .foregroundColor(.gray)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(bgColor)
                            .shadow(color: .white, radius: 10, x: -7, y: -7)
                            .shadow(color: grayColor, radius: 10, x: 7, y: 7)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.gray, lineWidth: 0)
                    }
            }
        }
    }
}

struct GrassmorphismButton: View {
    let frontGradientView = LinearGradient(gradient: .init(colors: [.yellow, .red]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
    let backGradientView = LinearGradient(gradient: .init(colors: [.red, .blue]),
                                          startPoint: .topLeading,
                                          endPoint: .bottomTrailing)

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 200, height: 200)
                .offset(x: 50, y: 50)
                .foregroundStyle(backGradientView)

            Circle()
                .frame(width: 200, height: 200)
                .offset(x: 50, y: 50)
                .foregroundStyle(frontGradientView)

            Button {} label: {
                Text("Grassmorphism Button")
                    .font(.system(size: 25, weight: .semibold, design: .default))
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(.ultraThinMaterial)
                            .shadow(color: .init(white: 0.4, opacity: 0.4), radius: 5)
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color(white: 1, opacity: 0.5), lineWidth: 1)
                    }
            }
        }
    }

}

struct ClaymorphismButton: View {
    let bgColor = Color(red:0.90, green: 0.92, blue: 0.98)
    let buttonColor = Color(red: 0.38, green: 0.28, blue: 0.86)
    let lightColor = Color(red: 0.54, green: 0.41, blue: 0.95)
    let shadowColor = Color(red: 0.25, green: 0.17, blue: 0.75)
    let radius = CGFloat(25)

    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()

            Button {} label: {
                Text("Claymorphism Button")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 20)
                    .background {
                        RoundedRectangle(cornerRadius: radius)
                            .fill(
                                .shadow(.inner(color: lightColor, radius: 6, x: 4, y: 4))
                                .shadow(.inner(color: shadowColor, radius: 6, x: -2, y: -2))
                            )
                            .foregroundColor(buttonColor)
                            .shadow(color: buttonColor, radius: 20, y: 10)
                    }
            }
        }
    }
}

struct VariableButtons_Previews: PreviewProvider {
    static var previews: some View {
        VariableButtons()
    }
}
