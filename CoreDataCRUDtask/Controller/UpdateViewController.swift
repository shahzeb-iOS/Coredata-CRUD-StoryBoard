//
//  UpdateViewController.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 19/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var updateBtn:UIBarButtonItem!
    @IBOutlet weak var cancelBtn:UIBarButtonItem!
    @IBOutlet weak var UserloginEmail:UILabel!
    @IBOutlet weak var userName:UITextField!
    @IBOutlet weak var enterEmail:UITextField!
    @IBOutlet weak var doB:UITextField!
    @IBOutlet weak var phoneNumber:UITextField!
    @IBOutlet weak var oldPwd:UITextField!
    @IBOutlet weak var newPwd:UITextField!
    @IBOutlet weak var updateImages:UIImageView!
    var imagesdata:Data!
    var imagePicker = UIImagePickerController()
    var helper = DatabaseHelper()
    var regex = SignupViewController()
    let datePicker = UIDatePicker()
    let dateformatter = DateFormatter()
    var currentEmail:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        createDatePicker()
        UserloginEmail.text = currentEmail
        Selecteddata(employee: helper.getItemsaccordingEmail(email: currentEmail))
    }
    func Selecteddata(employee:[Employee])
    {
        let item = employee
        for value in item
        {

            //imagesdata:Data!
            updateImages.image = UIImage(data:value.image as! Data)
            imagesdata =  updateImages.image!.jpegData(compressionQuality: 1)
            userName.text = value.username
            enterEmail.text = value.email
            dateformatter.dateStyle = .medium
            doB.text = dateformatter.string(from: value.dob! as Date)
            phoneNumber.text = value.phonenumber
            oldPwd.text = value.password
        }
    }
    @IBAction func chooseImage()
    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
        {
            //after complete
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey:Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        {
            updateImages.image = image
            //convert image into data
            imagesdata =  updateImages.image!.jpegData(compressionQuality: 1)
        }
        picker.dismiss(animated: true, completion: nil)
   }

    @IBAction func updatePressed(_ sender: Any) {
        if ((userName.text?.isEmpty)! || ((enterEmail.text?.isEmpty)!) || (phoneNumber.text?.isEmpty)! || (oldPwd.text?.isEmpty)! || (newPwd.text?.isEmpty)! || (doB.text?.isEmpty)!) || (enterEmail?.text?.isEmpty)! == true
        {
            showSimpleAlert(title: "Alert", msg: "Fill properly", btn: "ok")
           // print("Fill fields properly")
        }
        else if (enterEmail.text != currentEmail )
        {
             if isemailValid(emailId: enterEmail.text!) == true
            {
                if helper.checkIfEmailMatch(email: enterEmail.text!) == true
                {
                    //alert already user exist
                    showSimpleAlert(title: "Alert", msg: "Already user exist with this email", btn: "ok")
                }
                else
                {

                    helper.updateRecords(updatedEmail: enterEmail.text!, currentemail: currentEmail, name: userName.text!, phone: phoneNumber.text!, pass: newPwd.text!, dateOfBirth: datePicker.date,getImage:imagesdata)
                     performSegue(withIdentifier: "updatetoregistered", sender: self)
                    print("saved")
                }
            }
             else
             {
                //email pattern not matched
                showSimpleAlert(title: "Alert", msg: "Enter Valid email", btn: "OK")
             }
        }
        else
        {
            helper.updateRecords(updatedEmail: enterEmail.text!, currentemail: currentEmail, name: userName.text!, phone: phoneNumber.text!, pass: newPwd.text!, dateOfBirth: datePicker.date,getImage:imagesdata)
            performSegue(withIdentifier: "updatetoregistered", sender: self)
        }

    }
    @IBAction func cancel(_ sender: Any)
    {
        performSegue(withIdentifier: "updatetoregistered", sender: self)
    }
    // Marks:- AlertBox
    func showSimpleAlert(title:String,msg:String,btn:String)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertAction.Style.default, handler:{ _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        // assign toolbar
        doB.inputAccessoryView = toolbar
        //assign date picker to txt field
        doB.inputView = datePicker
        //date picker mode
        datePicker.datePickerMode = .date
    }
    @objc func donePressed() {
        //formatting the date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        //parsing the date into fields
        doB.text = formatter.string(from: datePicker.date)
        print(doB.text)
        self.view.endEditing(true)
    }
    func isemailValid(emailId:String)->Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailId)
    }
}
