//
//  NewReceiptViewModel.swift
//  Reminder
//
//  Created by Gabriel Roveri on 02/05/25.
//

final class NewReceiptViewModel {
    func addReceipt(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        DBHelper.shared.insertReceipt(remedy: remedy, time: time, recurrence: recurrence, takeNow: takeNow)
    }
}
