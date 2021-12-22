//
//  LoginViewController.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit
import CoreData
class LoginViewController: UIViewController {
    let helper = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidAppear(_ animated: Bool) {
            if(UserDefaults.standard.string(forKey: "getUserFlag") == "True")
            {
                  performSegue(withIdentifier: "registeredUsers", sender: self)
            }
            else
            {
                 print("New user")
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Round button
        self.CircularButton()
        //Marks:-Email and password verification
    }
    @IBAction func loginBtnA(_ sender: Any) {
  self.CheckFilledProperly(email: emailTxt.text!, Upwd: password.text!)

    }
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "Signup", sender: self)
        UserDefaults.standard.set("false", forKey: "getUserFlag")
    }

    func CircularButton() {
        loginBtn.layer.cornerRadius = 8
        loginBtn.layer.borderWidth = 1
    }
    func CheckFilledProperly(email:String,Upwd:String)  {
        if(email.isEmpty || Upwd.isEmpty) == true
        {
            self.showSimpleAlert(title: "Empty", msg: "Fill properly", btn: "recheck")
        }
        else if helper.checkIfEmailMatch(email: emailTxt.text!) == true {
            if helper.checkIfEmailExist(email: emailTxt.text!, pwd: password.text!) == true
            {
                UserDefaults.standard.set(emailTxt.text, forKey: "CurrentLogin")
               UserDefaults.standard.set("True", forKey: "getUserFlag")
                performSegue(withIdentifier: "registeredUsers", sender: self)
            }
            else {
                showSimpleAlert(title: "Alert", msg: "Wrong Password", btn: "retype")
            }
        }
        else {
            showSimpleAlert(title: "Alert", msg: "User not found", btn: "ok")
        }
    }
    func showSimpleAlert(title:String,msg:String,btn:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertAction.Style.default, handler:{ _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func forgetPassword(_ sender:Any) {
        performSegue(withIdentifier: "forgetVC", sender: self)
    }

}
