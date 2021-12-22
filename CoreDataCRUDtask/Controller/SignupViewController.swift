//
//  SignupViewController.swift
//  CoreDataCRUDtask
//
//  Created by Shahzaib khan on 18/11/2021.
//  Copyright © 2021 Shahzaib khan. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    @IBOutlet weak var chooseBtn:UIButton!
    @IBOutlet weak var ChooseImage:UIImageView!
    var chosenImage : UIImage!
    @IBOutlet weak var userName:UITextField!
     @IBOutlet weak var email:UITextField!
     @IBOutlet weak var cellNumber:UITextField!
     @IBOutlet weak var dob:UITextField!
     @IBOutlet weak var pwd:UITextField!
     @IBOutlet weak var cPwd:UITextField!
    @IBOutlet weak var signUp:UIButton!
    var imagePicker = UIImagePickerController()
    var imagesdata:Data = #imageLiteral(resourceName: "signup").jpegData(compressionQuality: 1)!
    let datePicker = UIDatePicker()
    let date  = DifferentVaraitions()
    let helper = DatabaseHelper()
    override func viewDidLoad() {
        imagePicker.delegate = self
        super.viewDidLoad()
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func choosefromGallery(_ sender:AnyObject)
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
        ChooseImage.image = image
        //convert image into data
        imagesdata =  ChooseImage.image!.jpegData(compressionQuality: 1)!
        }

        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func CreatedAccount(_ sender:Any)
    {
        self.checkingdataIntextfeilds()
    }
    @IBAction func alreadyAccount(_ sender:Any) {
        performSegue(withIdentifier: "loginScreen", sender: self)
    }
    //Marks:-Different  confirmation
    func checkingdataIntextfeilds() {
        if ((userName.text)!.isEmpty) || ((email.text)!.isEmpty) || ((cellNumber.text)!.isEmpty) , ((pwd.text)!.isEmpty) || ((cPwd.text)!.isEmpty) ||  ((dob.text)!.isEmpty) || (imagesdata.isEmpty) {
    self.showSimpleAlert(title: "Empty", msg: "Fill the fields properly", btn: "back")
    }
    //Checking email
    else if isemailValid(emailId: email.text!) == false {
    self.showSimpleAlert(title: "invalid ", msg: "Enter email again", btn: "ok")
    }
    else if helper.checkIfEmailMatch(email: email.text!)==true
            {
                self.showSimpleAlert(title: "Email exist", msg: "This Email  registred already", btn: "OK")
            }
    //checking pwd
    else if((pwd.text)! != (cPwd.text)!) {
    self.showSimpleAlert(title: "Password Issue", msg: "Password didn't match", btn: "Try again")
    }
    else {
            helper.createItems(userName: userName.text!, email: email.text!, phoneNumber:cellNumber.text!, DOB: datePicker.date, password: pwd.text!,getImage:imagesdata)
            performSegue(withIdentifier: "loginScreen", sender: self)
        }
}
    //Marks:- Email regex
    func isemailValid(emailId:String)->Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: emailId)
    }
    //Marks:- CellNumber
    func isPhonenumberisValid(number:String) -> Bool
    {
        let Cellnumber = "[0-9]"
        let testNumber = NSPredicate(format: "SELF MATCHES %@", Cellnumber)
        return testNumber.evaluate(with: number)
    }
    @objc func donePressed() {
        //formatting the date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        //parsing the date into fields
        dob.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        //bar button
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        // assign toolbar
        dob.inputAccessoryView = toolbar
        //assign date picker to txt field
        dob.inputView = datePicker
        //date picker mode
        datePicker.datePickerMode = .date
    }
    // Marks:- AlertBox
    func showSimpleAlert(title:String,msg:String,btn:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btn, style: UIAlertAction.Style.default, handler:{ _ in
            //Cancel Action
        }))
        self.present(alert, animated: true, completion: nil)
    }

}
