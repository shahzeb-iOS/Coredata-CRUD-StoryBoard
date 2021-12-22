//
//  ForgetViewController.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 23/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit
class ForgetViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var enterEmail:UITextField!
    @IBOutlet weak var searchBtn:UIButton!
    @IBOutlet weak var password:UILabel!
    let helper = DatabaseHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmail.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func searching(_ sender:Any)
    {
        searchEmail(email: enterEmail.text!)
    }
    func searchEmail(email:String)
    {
        if email.isEmpty {
            showSimpleAlert(title: "Alert", msg: "Enter email pls", btn: "Ok")
        }
        else if isemailValid(emailId: email) == false
        {
            showSimpleAlert(title: "alert", msg: "enter valid email", btn: "Try again")
        }
        else if helper.checkIfEmailMatch(email: email) == false
        {
            showSimpleAlert(title: "alert", msg: "User Not Found", btn: "Try again")
        }
        else
        {
            let item = helper.getItemsaccordingEmail(email: email)

            for user in item
            {
                password.text = user.password
            }
        }
    }
    func isemailValid(emailId:String)->Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailId)
    }
    @IBAction func home(_sender:Any)
    {
        performSegue(withIdentifier: "Loginagain", sender: self)
    }

    func showSimpleAlert(title:String,msg:String,btn:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertAction.Style.default, handler:{ _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
