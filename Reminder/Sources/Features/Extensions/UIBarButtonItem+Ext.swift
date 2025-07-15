//
//  UIBarButtonItem+Ext.swift
//  Reminder
//
//  Created by Gabriel Roveri on 18/04/25.
//

import UIKit

extension UIBarButtonItem {
    convenience init(image: UIImage?, style: UIBarButtonItem.Style, handler: @escaping () -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.target = self
        self.action = #selector(handleTap)

        objc_setAssociatedObject(self, &associatedObjectHandle, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    @objc private func handleTap() {
        guard let handler = objc_getAssociatedObject(self, &associatedObjectHandle) as? () -> Void else { return }
        handler()
    }
}

private var associatedObjectHandle: UInt8 = 0
