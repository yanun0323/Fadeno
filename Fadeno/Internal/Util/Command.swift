//
//  Command.swift
//  Fadeno
//
//  Created by Yanun on 2022/10/29.
//

import SwiftUI
import UIComponent

extension View {
    func TextediterCommand() -> some View {
        self
            .hotkey(key: .kVK_ANSI_A, keyBase: [.command]) {
                NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_C, keyBase: [.command]) {
                NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_X, keyBase: [.command]) {
                NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_V, keyBase: [.command]) {
                NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [.command]) {
                NSApp.sendAction(Selector(("undo:")), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [.shift, .command]) {
                NSApp.sendAction(Selector(("redo:")), to:nil, from:self)
            }
    }
}

//CommandMenu("Edit") {
//    Section {
//        // MARK: - `Select All` -
//        Button("Select All") {
//            NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
//        }
//        .keyboardShortcut(.a)
//
//        // MARK: - `Cut` -
//        Button("Cut") {
//            NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: nil)
//        }
//        .keyboardShortcut(.x)
//
//        // MARK: - `Copy` -
//        Button("Copy") {
//            NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
//        }
//        .keyboardShortcut(.c)
//
//        // MARK: - `Paste` -
//        Button("Paste") {
//            NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: nil)
//        }
//        .keyboardShortcut(.v)
//    }
//    }
