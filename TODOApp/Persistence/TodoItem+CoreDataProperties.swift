//
//  TodoItem+CoreDataProperties.swift
//  TODOApp
//
//  Created by Tatiana Carvajal on 28/06/23.
//
//

import Foundation
import CoreData


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var activity: String
    @NSManaged public var date: Date

}

extension TodoItem : Identifiable {

}
