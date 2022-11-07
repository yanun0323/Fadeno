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
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(delegate.container)
                .TextEditerCommand()
                .frame(minWidth: 1200, minHeight: 600)
                .background(.background)
                .onAppear {
                    NSApp.appearance = delegate.container.interactor.usersetting.GetAppearance()
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

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var statusItem: NSStatusItem?
    private var popOver = NSPopover()
    var container = DIContainer()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        NSApp.appearance = container.interactor.usersetting.GetAppearance()
        
//        mainViewModel.PopOver = popOver
        popOver.setValue(true, forKeyPath: "shouldHideAnchor")
        popOver.contentSize = CGSize(width: 1200, height: 600)
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController = NSHostingController(rootView: ContentView()
            .inject(container)
        )
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        var img = NSImage(named: "multithread.fill")
        var config = NSImage.SymbolConfiguration(textStyle: .body, scale: .large)
        config = config.applying(.init(paletteColors: [
            .init(red: 0, green: 0.5, blue: 1, alpha: 1),
            .init(red: 0.9, green: 0.2, blue: 0.2, alpha: 1)]))
        img = img?.withSymbolConfiguration(config)
        
        if let statusButton = statusItem?.button {
            statusButton.image = img
            statusButton.action = #selector(togglePopover)
        }
    }
    
    @objc func togglePopover() {
        if let button = statusItem?.button {
            self.popOver.show(relativeTo:  button.bounds, of: button, preferredEdge: NSRectEdge.minY)
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
