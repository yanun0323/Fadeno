//
//  FadenoApp.swift
//  Fadeno
//
//  Created by YanunYang on 2022/9/20.
//

import SwiftUI
import UIComponent
import AppKit

@main
struct FadenoApp: App {
    private var container: DIContainer
    
    init() {
        container = DIContainer(isMock: false)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(container)
                .frame(minWidth: 900, minHeight: 600)
                .onAppear {
                    NSApp.appearance = container.interactor.usersetting.GetAppearance()
                }
        }
        .commands {
                CommandMenu("Edit") {
                    Section {
                        // MARK: - `Select All` -
                        Button("Select All") {
                            NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
                        }
                        .keyboardShortcut(.a)
                        
                        // MARK: - `Cut` -
                        Button("Cut") {
                            NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: nil)
                        }
                        .keyboardShortcut(.x)
                        
                        // MARK: - `Copy` -
                        Button("Copy") {
                            NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
                        }
                        .keyboardShortcut(.c)
                        
                        // MARK: - `Paste` -
                        Button("Paste") {
                            NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: nil)
                        }
                        .keyboardShortcut(.v)
                    }
                }
            }
    }
}

fileprivate struct KeyboardEventModifier: ViewModifier {
    enum Key: String {
        case a, c, v, x
    }
    
    let key: Key
    let modifiers: EventModifiers
    
    func body(content: Content) -> some View {
        content.keyboardShortcut(KeyEquivalent(Character(key.rawValue)), modifiers: modifiers)
    }
}

extension View {
    fileprivate func keyboardShortcut(_ key: KeyboardEventModifier.Key, modifiers: EventModifiers = .command) -> some View {
        modifier(KeyboardEventModifier(key: key, modifiers: modifiers))
    }
}
