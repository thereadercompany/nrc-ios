//
//  SQLiteDatabase.swift
//  boeckler
//
//  Created by Emiel van der Veen on 06/05/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation

protocol SQLiteDatabaseFactory {
    func create() -> Database
}

class SQLiteDiskDatabaseFactory: SQLiteDatabaseFactory {
    
    let databasePath: String
    
    init(databasePath: String) {
        self.databasePath = databasePath
    }
    
    //MARK: Tables
    private func createTables(database: Database) {
        addTables([BlockContextTable.self, BlockTable.self, RelationshipTable.self, ObjectTable.self], database: database)
    }
    
    private func addTables(tables: [Table.Type], database: Database) {
        for table in tables {
            table.create(inDatabase: database)
        }
    }
    
    func create() -> Database {
        let database = Database(databasePath)
        let manager = NSFileManager.defaultManager()
        let databaseExists = manager.fileExistsAtPath(databasePath)
        if !databaseExists {
            createTables(database)
        }
        return database
    }
}
