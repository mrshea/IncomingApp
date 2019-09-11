//
//  schoolCodeViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/2/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//
import UIKit
import FirebaseStorage
import Firebase


class schoolCodeViewController: UIViewController {
    
    @IBOutlet weak var pinCodeTextField: PinCodeTextField!
    @IBOutlet weak var invalid: UILabel!
    var schoolCode:String = ""
    var schoolName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        invalid.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.pinCodeTextField.becomeFirstResponder()
        }
        
        pinCodeTextField.delegate = self
        pinCodeTextField.keyboardType = .numberPad
        
        
        let toolbar = UIToolbar()
        let nextButtonItem = UIBarButtonItem(title: NSLocalizedString("NEXT",
                                                                      comment: ""),
                                             style: .done,
                                             target: self,
                                             action: #selector(pinCodeNextAction))
        toolbar.items = [nextButtonItem]
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        pinCodeTextField.inputAccessoryView = toolbar
        
    }

    @IBAction func next(_ sender: AnyObject) {
        
        let modalViewController = self.storyboard?.instantiateViewController(identifier: "SignUpInfo") as? SignUpViewController
        modalViewController!.modalPresentationStyle = .overCurrentContext
        self.schoolCode = pinCodeTextField.text ?? ""
        getSchoolName(){ (isSucceeded) in
            if isSucceeded{
                    modalViewController!.schoolCode = self.schoolCode
                    modalViewController!.schoolName = self.schoolName
                    self.present(modalViewController!, animated: true, completion: nil)
            }else{
                    self.invalid.isHidden = false
            }
        }

    }
    
    
    func getSchoolName(completion: @escaping (Bool) -> Void){
        let db = Firestore.firestore()

        print(self.schoolCode)
        let docRef = db.collection("schools").document(schoolCode)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists{
                let property = document.get("name")
                self.schoolName = property as! String
                completion(true)
                
                //completion(true)
            } else {
                print("Document does not exist")
                completion(false)
            }
        }
    
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        print("hi")
        
        
        
    }
    override public var prefersStatusBarHidden: Bool {
        return false
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    @objc private func pinCodeNextAction() {
        print("next tapped")
    }
}


extension schoolCodeViewController: PinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: PinCodeTextField) {
        
    }
    
    func textFieldValueChanged(_ textField: PinCodeTextField) {
        let value = textField.text ?? ""
        print("value changed: \(value)")
    }
    
    func textFieldShouldEndEditing(_ textField: PinCodeTextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: PinCodeTextField) -> Bool {
        return true
    }
}

