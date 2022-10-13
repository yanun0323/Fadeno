import Foundation
import SwiftUI
import AppKit
import Combine

class AppState: ObservableObject {
    @Published var shared: SharedState
    @Published var userSetting: UserSetting
    
    init(shared: SharedState) {
        self.shared = shared
        self.userSetting = UserSetting()
    }
}

extension AppState {
    class SharedState: ObservableObject {
        @Published var page: Int
        @Published var currentTask: UserTask
        @Published var tasks: [UserTask]
        
        init(page: Int = 0, tasks: [UserTask] = []) {
            self.page = page
            self.tasks = tasks
            self.currentTask = tasks.first ?? UserTask.empty
        }
    }
}

extension AppState {
    struct UserSetting {
        private var _autoArchive: Bool = UserDefaults.standard.bool(forKey: "AutoArchive")
        var autoArchive: Bool {
            get {
                return _autoArchive
            }
            set {
                self._autoArchive = newValue
                UserDefaults.standard.set(_autoArchive, forKey: "AutoArchive")
            }
        }
        
        private var _popoverWidth: Double = UserDefaults.standard.double(forKey: "PopoverWidth")
        var popoverWidth: Double {
            get {
                return _popoverWidth == 0 ? Config.Popover.MinWidth : _popoverWidth
            }
            set {
                self._popoverWidth = newValue
                UserDefaults.standard.set(_popoverWidth, forKey: "PopoverWidth")
            }
        }
        
        private var _popoverClick: Bool = UserDefaults.standard.bool(forKey: "PopoverClick")
        var popoverClick: Bool {
            get {
                return _popoverClick
            }
            set {
                self._popoverClick = newValue
                UserDefaults.standard.set(_popoverClick, forKey: "PopoverClick")
            }
        }
        
        private var _popoverAutoClose: Bool = UserDefaults.standard.bool(forKey: "PopoverAutoClose")
        var popoverAutoClose: Bool {
            get {
                return _popoverAutoClose
            }
            set {
                self._popoverAutoClose = newValue
                UserDefaults.standard.set(_popoverAutoClose, forKey: "PopoverAutoClose")
            }
        }
        
        private var _windowsWidth: Double = UserDefaults.standard.double(forKey: "WindowsWidth")
        var windowsWidth: Double {
            get {
                return _windowsWidth == 0 ? Config.Windows.MinWidth : _windowsWidth
            }
            set {
                self._windowsWidth = newValue
                UserDefaults.standard.set(_windowsWidth, forKey: "WindowsWidth")
            }
        }
        
        private var _windowsHeight: Double = UserDefaults.standard.double(forKey: "WindowsHeight")
        var windowsHeight: Double {
            get {
                return _windowsHeight == 0 ? Config.Windows.MinHeight : _windowsHeight
            }
            set {
                self._windowsHeight = newValue
                UserDefaults.standard.set(_windowsHeight, forKey: "WindowsHeight")
            }
        }
        
        private var _swapEmergencyBlock: Bool = UserDefaults.standard.bool(forKey: "SwapEmergencyBlock")
        var swapEmergencyBlock: Bool {
            get {
                return _swapEmergencyBlock
            }
            set {
                self._swapEmergencyBlock = newValue
                UserDefaults.standard.set(_swapEmergencyBlock, forKey: "SwapEmergencyBlock")
            }
        }
        
        private var _hideBlock: Bool = UserDefaults.standard.bool(forKey: "HideBlock")
        var hideBlock: Bool {
            get {
                return _hideBlock
            }
            set {
                self._hideBlock = newValue
                UserDefaults.standard.set(_hideBlock, forKey: "HideBlock")
            }
        }
        
        private var _hideEmergency: Bool = UserDefaults.standard.bool(forKey: "HideEmergency")
        var hideEmergency: Bool {
            get {
                return _hideEmergency
            }
            set {
                self._hideEmergency = newValue
                UserDefaults.standard.set(_hideEmergency, forKey: "HideEmergency")
            }
        }
        
        private var _appearance: Int = UserDefaults.standard.integer(forKey: "Theme")
        
        /**
        User stored appearance
         
         0 : system
         
         1 : light
         
         2 : dark
         */
        var appearanceInt: Int {
            get {
                _appearance
            }
        }
        
        var appearance: NSAppearance? {
            get {
                switch _appearance {
                case 1:
                    return NSAppearance(named: .aqua)
                case 2:
                    return NSAppearance(named: .darkAqua)
                default:
                    return nil
                }
            }
            set {
                switch newValue {
                case NSAppearance(named: .aqua):
                    self._appearance = 1
                    #if DEBUG
                    print("Set Light Mode")
                    #endif
                case NSAppearance(named: .darkAqua):
                    self._appearance = 2
                    #if DEBUG
                    print("Set Light Mode")
                    #endif
                default:
                    self._appearance = 0
                    #if DEBUG
                    print("Set Light Mode")
                    #endif
                }
                UserDefaults.standard.set(_appearance, forKey: "Theme")
            }
        }
        
        
    }
}
