//
//  UIView+Ext.swift
//  Reminder
//
//  Created by Gabriel Roveri on 23/04/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
