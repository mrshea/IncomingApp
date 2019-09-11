//
//  LoginViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper
import Firebase
import FirebaseStorage

class LoginViewController: UIViewController {
    
    
    var userUID: String!
    var email:String!

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let back = UISwipeGestureRecognizer(target: self, action: #selector(swipeBackLogin(swipe:)))
        back.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(back)
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
        
    }
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            
            
            
            
            
            
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
               let user = Auth.auth().currentUser
               if let user = user{
                   
                   self.userUID = user.uid
                   self.email = user.email
                   KeychainWrapper.standard.set(user.uid, forKey: "uid")
               }
                
             
                
                
                
                
                
                
                
                let ContainerViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.ContainerViewController) as? ContainerViewController
                    
                    self.view.window?.rootViewController = ContainerViewController
                    self.view.window?.makeKeyAndVisible()
                
                    
                
            }
        }
    }
    
}
extension UIViewController{
    @objc func swipeBackLogin(swipe: UISwipeGestureRecognizer){
        switch swipe.direction.rawValue {
        case 1:
            performSegue(withIdentifier: "back", sender: self)
        default:
            break
        }
        
    }
    
    
    
    
}
