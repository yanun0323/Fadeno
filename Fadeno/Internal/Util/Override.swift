//
//  Override.swift
//  Fadeno
//
//  Created by YanunYang on 2022/9/21.
//

import AppKit

extension NSTableView {
    open override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        backgroundColor = NSColor.clear
        enclosingScrollView!.drawsBackground = false
        enclosingScrollView!.hasVerticalScroller = false
        enclosingScrollView!.hasHorizontalScroller = false
    }
}

extension NSTextView {
    open override var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
            enclosingScrollView?.drawsBackground = false
            enclosingScrollView?.hasVerticalScroller = false
            enclosingScrollView?.hasHorizontalScroller = false
        }
    }
}
