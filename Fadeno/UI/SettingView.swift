//
//  SettingView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/28.
//

import SwiftUI
import UIComponent
import AppKit

struct SettingView: View {
    @EnvironmentObject var container: DIContainer
    @State var appearance: NSAppearance? = nil
    var body: some View {
        VStack {
            ThemeBlock
                .padding()
            Rectangle()
                .foregroundColor(.transparent)
                .overlay {
                    Text("Setting View")
                }
        }
        .onAppear {
            appearance = container.interactor.usersetting.GetAppearance()
        }
        .onReceive(container.appstate.usersetting.appearance) { value in
            appearance = value
        }
    }
}

// MARK: ViewBlock
extension SettingView {
    var ThemeBlock: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Appreance")
                    .foregroundColor(.primary50)
                    .font(.caption)
                Spacer()
            }.padding(.horizontal)
            HStack(spacing: 20) {
                Spacer()
                VStack(spacing: 10) {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            container.interactor.usersetting.SetAppearance(0)
                        }
                    } content: {
                        ZStack {
                            LightImage
                                .mask {
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .frame(width: 29.5)
                                        Spacer()
                                    }
                                }
                            DarkImage
                                .offset(x: 30, y: 0)
                                .mask {
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Rectangle()
                                            .frame(width: 29.5)
                                    }
                                }
                        }
                        .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 3))
                            .opacity(appearance == nil ? 1 : 0)
                    )
                    Text("System")
                }
                VStack(spacing: 10)  {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            container.interactor.usersetting.SetAppearance(1)
                        }
                    } content: {
                        LightImage
                            .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 3))
                            .opacity(appearance?.name == .aqua ? 1 : 0)
                )
                    Text("Light")
                }
                VStack(spacing: 10)  {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            container.interactor.usersetting.SetAppearance(2)
                        }
                    } content: {
                        DarkImage
                            .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2.5))
                            .opacity(appearance?.name == .darkAqua ? 1 : 0)
                    )
                    Text("Dark")
                }
                Spacer()

            }
            .padding(.vertical)
            .background(Color.primary.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    var LightImage: some View {
        Image("Light")
            .resizable()
            .overlay {
                ZStack {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(Color.black.opacity(0.3))
                        .offset(x: 0, y: -20)
                    ZStack {
                        VStack {
                            HStack(spacing: 3) {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 5, height: 5)
                                Spacer()
                            }
                            .padding(3)
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 30)
                        }
                    }
                    .frame(width: 60, height: 40)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(5)
                    .offset(x: 10, y: 20)
                }
            }
            .clipShape(Rectangle())
    }
    
    var DarkImage: some View {
        Image("Dark")
            .resizable()
            .overlay {
                ZStack {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(Color.black.opacity(0.3))
                        .offset(x: 0, y: -20)
                    VStack {
                        HStack(spacing: 3) {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 5, height: 5)
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: 5, height: 5)
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 5, height: 5)
                            Spacer()
                        }
                        .padding(3)
                        Spacer()
                    }
                    .frame(width: 60, height: 40)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(5)
                    .offset(x: 10, y: 20)
                }
            }
            .clipShape(Rectangle())
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .inject(DIContainer.preview)
    }
}
