//
//  CheckEmptyFields.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 19/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import Foundation
import UIKit
class CheckEmptyFields {
    func TextfieldsEmailandPassword(email:String,password:String) -> Bool {
        if(email.isEmpty || password.isEmpty) == true
        {
            return true
        }
        else
        {
            return false
        }
    }
}
