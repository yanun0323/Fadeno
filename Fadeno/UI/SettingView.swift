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
    @EnvironmentObject private var container: DIContainer
    @State private var clickUpToken = ""
    @State private var clickUpTokenConfirm = false
    @State private var clickUpTokenOK = false
    @State private var clickUpTokenVerifying = false
    @State private var timer: CacheTimer? = nil
    @State private var initial = true
    @State private var taskbarVertical = false
    
    /* cache */
    @State private var appearance: NSAppearance? = nil
    
    private var token: String {
        clickUpToken
    }
    
    @State var current: [Usertask.Tasktype] = [.archived, .normal]
    var body: some View {
        VStack(spacing: 20) {
            ThemeBlock
                .padding(.top, 20)
//            ClickupTokenBlock
            TaskbarVerticalBlock
            Block()
        }
        .onAppear {
            if !initial { return }
            appearance = container.interactor.usersetting.GetAppearance()
            taskbarVertical = container.interactor.usersetting.GetTaskbarVertical()
            
            clickUpToken = container.interactor.clickup.GetToken()
            clickUpTokenConfirm = !clickUpToken.isEmpty
            clickUpTokenOK = !clickUpToken.isEmpty
            timer = CacheTimer(countdown: 2, timeInterval: 1, action: {
                container.interactor.clickup.VerifyToken(token)
            })
            timer?.Activate()
        }
        .onReceive(container.appstate.usersetting.appearance) { value in
            appearance = value
        }
        .onReceive(container.appstate.clickup.tokenVerify) { value in
            clickUpTokenVerifying = false
            clickUpTokenOK = value
        }
    }
}

// MARK: ViewBlock
extension SettingView {
    var TaskbarVerticalBlock: some View {
        Toggle(isOn: Binding(
            get: {
                taskbarVertical
            }, set: { value in
                container.interactor.usersetting.SetTaskbarVertical(value)
                taskbarVertical = value
            })) {
                Text("setting.taskbar.vertical")
            }
    }
    
    var ClickupTokenBlock: some View {
        Section(title: "clickup.token") {
            VStack {
                HStack {
                    if clickUpTokenVerifying {
                        LoadingCircle(color: .yellow ,size: 12, lineWidth: 2, speed: 1)
                            .colorMultiply(.yellow)
                        Text("Verifying")
                            .foregroundColor(.yellow)
                            .colorMultiply(.yellow)
                    } else if clickUpTokenOK {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.green)
                            .colorMultiply(.green)
                        Text("OK")
                            .foregroundColor(.green)
                            .colorMultiply(.green)
                    } else {
                        Image(systemName: "multiply")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.red)
                            .colorMultiply(.red)
                        Text("Invalid Token")
                            .foregroundColor(.red)
                            .colorMultiply(.red)
                    }
                }
                HStack {
                    SecureField("clickup.token.input", text: Binding(
                        get: {
                            clickUpToken
                        }, set: { value in
                            clickUpToken = value
                            if initial {
                                initial = false
                                return
                            }
                            timer?.Refresh()
                            clickUpTokenOK = false
                            clickUpTokenVerifying = true
                        }))
                        .textFieldStyle(.plain)
                        .padding(5)
                        .background()
                        .cornerRadius(5)
                        .disabled(clickUpTokenConfirm)
                    ButtonCustom(width: 70, height: 25) {
                        clickUpTokenConfirm.toggle()
                    } content: {
                        Text(clickUpTokenConfirm ? "clickup.token.input.cancel" : "clickup.token.input.lock")
                    }
                    .background()
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    .disabled(!clickUpTokenConfirm && !clickUpTokenOK)

                }
            }
        }
    }
}

// MARK: ThemeBlock
extension SettingView {
    var ThemeBlock: some View {
        Section(title: "setting.appearance") {
            HStack(spacing: 40) {
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
                    Text("setting.system")
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
                    Text("setting.light")
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
                    Text("setting.dark")
                }
            }
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

extension SettingView {
    func Section(title: LocalizedStringKey, content: @escaping () -> some View) -> some View {
        VStack(spacing: 5) {
            HStack {
                Text(title)
                    .foregroundColor(.primary50)
                    .font(.caption)
                Spacer()
            }.padding(.horizontal, 10)
            HStack(spacing: 0, content: {
                Spacer()
                content()
                Spacer()
            })
            .padding()
            .background(Color.section)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(.horizontal)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .inject(DIContainer.preview)
    }
}
