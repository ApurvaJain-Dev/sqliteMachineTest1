//
//  databaseLibrary.swift
//  sqliteMachineTest1
//
//  Created by Student-001 on 25/09/19.
//  Copyright © 2019 apurva. All rights reserved.
//

import Foundation
import SQLite3

class databaseLibrary {
    static let sharedObj = databaseLibrary()
    var taskPrice = [String]()
    var taskName = [String]()
    
    func databasePath() -> String {
        
        let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path = dir.first!
        return path+"myDatabase.sqlite"
        
    }
    
    func executeQuery(query: String) -> Bool
    {
        let dbPath = databasePath()
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        var success: Bool = false
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                if sqlite3_step(stmt) == SQLITE_DONE
                {
                    success = true
                }
                else
                {
                    print("Error is step:\(sqlite3_errmsg(stmt!))")
                }
            }
            else
            {
                print("Error is prepare:\(sqlite3_errmsg(stmt))")
            }
        }
        else
        {
            print("Error in open:\(sqlite3_errmsg(stmt!))")
        }
        return success
    }

    
    func selectAllTask(query: String)
    {
        let dbPath = databasePath()
        var db: OpaquePointer? = nil
        var stmt: OpaquePointer? = nil
        // var success: Bool = false
        if sqlite3_open(dbPath, &db) == SQLITE_OK
        {
            if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK
            {
                
                //     success = true
               // taskName.removeAll()
               // taskId.removeAll()
                while sqlite3_step(stmt) == SQLITE_ROW
                {
                    let tName = sqlite3_column_text(stmt, 1)
                    let tasName = String(cString: tName!)
                    
                    taskName.append(tasName)
                    let tPrice = sqlite3_column_text(stmt, 0)
                    let tasPrice = String(cString: tPrice!)
                    
                    taskPrice.append(tasPrice)
                }
                
            }
                
            else
            {
                print("Error is prepare: \(sqlite3_errmsg(stmt!))")
            }
        }
        else
        {
            print("Error in open:\(sqlite3_errmsg(stmt!))")
        }
        
    }
    
    
    
    
    
    func createTable() {
      
        let createQuery = "create table if not exists foodMenu(taskName text, taskPrice text)"
        let isSuccess = executeQuery(query: createQuery)
        if isSuccess {
            print("table creation successful")
        }
        else
        {
            print("table creation failed")
        }
    }
    
}
