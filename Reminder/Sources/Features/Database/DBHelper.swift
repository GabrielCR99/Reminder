//
//  DBHelper.swift
//  Reminder
//
//  Created by Gabriel Roveri on 01/05/25.
//

import Foundation
import SQLite3

final class DBHelper {
    static let shared = DBHelper()
    private var database: OpaquePointer?

    private init() {
        openDatabase()
        createTable()
    }

    private func openDatabase() {
        let fileURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("reminder.sqlite")

        guard let fileURL = fileURL else {
            fatalError("Could not create file URL for database")
        }

        if sqlite3_open(fileURL.path, &database) != SQLITE_OK {
            fatalError("Error opening database")
        }
    }

    private func createTable() {
        let query = """
            CREATE TABLE IF NOT EXISTS Recipes (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                remedy TEXT,
                time TEXT,
                recurrence TEXT,
                takeNow INTEGER
            );
            """
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) != SQLITE_DONE {
                dump(sqlite3_errmsg(database))
            }
        }
        sqlite3_finalize(statement)
    }

    func insertRecipe(remedy: String, time: String, recurrence: String, takeNow: Bool) {
        let query = """
            INSERT INTO Recipes (remedy, time, recurrence, takeNow)
            VALUES (?, ?, ?, ?);
            """
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (remedy as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (time as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (recurrence as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, (takeNow ? 1 : 0))

            if sqlite3_step(statement) != SQLITE_DONE {
                dump(sqlite3_errmsg(database))
            }
        }
        sqlite3_finalize(statement)
    }

    func fetchRecipes() -> [Medicine] {
        let query = "SELECT * FROM Recipes;"
        var statement: OpaquePointer?
        var result: [Medicine] = []

        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let remedy =  sqlite3_column_text(statement, 1).flatMap { String(cString: $0)} ?? "Unknown"
                let time =  sqlite3_column_text(statement, 2).flatMap { String(cString: $0)} ?? "Unknown"
                let recurrence = sqlite3_column_text(statement, 3).flatMap { String(cString: $0)} ?? "Unknown"
                result.append(.init(id: id, title: remedy, time: time, recurrence: recurrence))
            }
        } else {
            dump(sqlite3_errmsg(database))
        }

        sqlite3_finalize(statement)

        return result
    }

    func deleteRecipeById(_ id: Int) {
        let query = "DELETE FROM Recipes WHERE id = ?;"
        var statement: OpaquePointer?

        if sqlite3_prepare_v2(database, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))

            if sqlite3_step(statement) != SQLITE_DONE {
                dump(sqlite3_errmsg(database))
            }

        }

        sqlite3_finalize(statement)
    }
}
