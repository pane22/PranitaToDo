//
//  ToDo+CoreDataProperties.swift
//  todoPranita
//
//  Created by Felix 12 on 28/09/19.
//  Copyright © 2019 SwarajyaIT. All rights reserved.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var mainCategory: String?
    @NSManaged public var task: String?

}
