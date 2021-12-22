//
//  alerts+DatePicker.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import Foundation
import UIKit
class DifferentVaraitions
{
     let datePicker = UIDatePicker()
    func datePicker(Datepicker:UITextField!)->UITextField
    {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        // assign toolbar
        Datepicker.inputAccessoryView = toolbar
        //assign date picker to txt field
        Datepicker.inputView = datePicker
        //date picker mode
        datePicker.datePickerMode = .date
        return Datepicker
    }
    @objc func donePressed(dob:UITextField) -> UITextField {
        //formatting the date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        //parsing the date into fields
        dob.text = formatter.string(from: datePicker.date)
        return dob
        
    }
}
