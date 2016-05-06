//
//  SQLiteDatabase.swift
//  boeckler
//
//  Created by Emiel van der Veen on 06/05/16.
//  Copyright © 2016 TRC. All rights reserved.
//

import Foundation

class SQLiteDatabase {
    
    let database: Database

    init(database: Database, databasePath: String) {
        let manager = NSFileManager.defaultManager()
        let databaseExists = manager.fileExistsAtPath(databasePath)
        self.database = database
        if !databaseExists {
            createTables()
        }
    }
    
    //MARK: Tables
    func createTables() {
        addTables([BlockContextTable.self, BlockTable.self, RelationshipTable.self, ObjectTable.self])
    }
    
    private func addTables(tables: [Table.Type]) {
        for table in tables {
            table.create(inDatabase: database)
        }
    }
}
