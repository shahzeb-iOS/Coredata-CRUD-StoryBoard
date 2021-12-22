//
//  Employee+CoreDataProperties.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var password: String?
    @NSManaged public var email: String?

}
