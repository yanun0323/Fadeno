//
//  CountDown.swift
//  Fadeno
//
//  Created by YanunYang on 2022/10/11.
//

import SwiftUI

class CountdownTrigger {
    @State var timer: Timer?
    @State var time: Int
    @State var action: () -> Void
    let nano: Int
    
    init(_ nanosecond: Int,_ action: @escaping () -> Void) {
        self.timer = nil
        self.time = 0
        self.nano = nanosecond
        self.action = action
    }
}

// MARK: Method
extension CountdownTrigger {
    func Refresh() {
        if time > 0 {
            time = nano
            return
        }
        
        time = nano
        timer = .scheduledTimer(
            withTimeInterval: 0.1,
            repeats: true,
            block: { t in
                if self.time > 0 {
                    self.time -= 1
                    return
                }
                
                self.timer?.invalidate()
                self.action()
            })
    }
}
