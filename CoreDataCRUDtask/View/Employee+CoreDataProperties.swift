//
//  Employee+CoreDataProperties.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 24/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var dob: NSDate?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var phonenumber: String?
    @NSManaged public var username: String?
    @NSManaged public var image: NSData?

}
