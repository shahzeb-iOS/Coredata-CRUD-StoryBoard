//
//  DatabaseHelper.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class DatabaseHelper  {
var item = [Employee]()
let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    func getItems() -> [Employee]
 {
        do {
            item = try! (context?.fetch(Employee.fetchRequest()))!
             return item
        }
        catch { print(error.localizedDescription) }

    }
    func createItems(userName:String,email:String,phoneNumber:String,DOB:Date,password:String,getImage:Data)
    {
        let newUsers = Employee(context: context!)
       newUsers.username = userName
        newUsers.email = email
        newUsers.phonenumber = phoneNumber
        newUsers.dob = DOB as NSDate
        newUsers.password = password
        newUsers.image = getImage as NSData
        do {
            try context!.save()
            print("sucesss")

        } catch  {
            print(error.localizedDescription)
        }
    }
    func Delete (file:Employee)
{
    context?.delete(file)
   do
   {
    try!context?.save()
   } catch { print(error.localizedDescription)}

    }
   //Marks:-Exist or not
    func checkIfEmailExist(email: String,pwd:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@ "  ,email,pwd)
        //  fetchRequest.predicate = NSPredicate(format: "type == %@" ,)

        do {
            let count = try context!.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }

    }
    func checkIfEmailMatch(email: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Employee")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "email == %@" ,email)
        //  fetchRequest.predicate = NSPredicate(format: "type == %@" ,)

        do {
            let count = try context!.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    func deleteobject(indexPath:IndexPath)
    {
        let getRowitem = item[indexPath.row]
        context?.delete(getRowitem)

        do{
            try context?.save()
        }
        catch
        {
            print("helloo mr handle your errors")
        }
    }
    func updateRecords(updatedEmail:String,currentemail:String,name: String , phone: String, pass:String, dateOfBirth: Date,getImage:Data)
    {
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context!)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "(email = %@)", currentemail)
        request.predicate = predicate
        do {
            var results = try context!.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            objectUpdate.setValue(name, forKey: "username")
            objectUpdate.setValue(phone, forKey: "phonenumber")
            objectUpdate.setValue(pass, forKey: "password")
            objectUpdate.setValue(dateOfBirth, forKey: "dob")
            objectUpdate.setValue(updatedEmail, forKey: "email")
            objectUpdate.setValue(getImage, forKey: "image")
            do {
                try context!.save()
                print("Record Updated")
            }catch let error as NSError {
                print("Error While Saving")
            }
        }
        catch let error as NSError {
            print("Error While Updating")
        }
    }
    func getItemsaccordingEmail(email:String) -> [Employee]
    {
        let fetchRequest:NSFetchRequest<Employee> = Employee.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@" ,email)

        do {
            item = try context!.fetch(fetchRequest)

        }
        catch { print(error.localizedDescription)

        }
        return item
    }
}

