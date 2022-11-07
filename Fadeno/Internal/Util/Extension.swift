import AppKit
import SwiftUI
import UIComponent

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
            drawsBackground = false
            enclosingScrollView?.drawsBackground = false
            enclosingScrollView?.hasVerticalScroller = false
            enclosingScrollView?.hasHorizontalScroller = false
        }
    }
}
