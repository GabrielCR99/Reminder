//
//  String+Ext.swift
//  Reminder
//
//  Created by Gabriel Roveri on 10/04/25.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
}
