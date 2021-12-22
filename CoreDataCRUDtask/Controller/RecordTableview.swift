//
//  ViewController.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit
class RecordTableview: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let helper = DatabaseHelper()
    let login = LoginViewController()
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var userlogin:UILabel!
    @IBOutlet weak var logout:UIBarButtonItem!
    let dateFormatter = DateFormatter()
    var getEmail:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        userlogin.text =  UserDefaults.standard.string(forKey: "registeredUsers")  ?? "Check DB processing"
        tableView.tableFooterView = UIView()
       // helper.getItems()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userstoupdate" {
        let vc = segue.destination as! UpdateViewController
            vc.currentEmail = getEmail
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getEmail = helper.getItems()[indexPath.row].email
        UserDefaults.standard.set(indexPath.row, forKey: "selectedRows")
        performSegue(withIdentifier: "userstoupdate", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //helper.getItems()
        return helper.getItems().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        dateFormatter.dateStyle = .medium
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ShowRecordTableViewCell
        //before show image that data must be converted into uiimage
        var images = helper.getItems()[indexPath.row].image! as Data

        cell.imageShow.image = UIImage(data:images)
        cell.name.text = helper.getItems()[indexPath.row].username
        cell.email.text = helper.getItems()[indexPath.row].email
        cell.cellNumber.text = helper.getItems()[indexPath.row].phonenumber
        cell.dateofBirth.text = dateFormatter.string(from: helper.getItems()[indexPath.row].dob! as Date)
        return cell
    }
     //this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // remove the item from the data model
            var refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertController.Style.alert)
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.helper.deleteobject(indexPath: indexPath)
                 tableView.reloadData()
                print("Handle Ok logic here")
            }))
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            present(refreshAlert, animated: true, completion: nil)
        }
    }
    @IBAction func logoutAction(_ sender:Any)
    {
        UserDefaults.standard.set("False", forKey: "getUserFlag")
        performSegue(withIdentifier: "Login", sender: self)
        print("User logout")
    }
}

