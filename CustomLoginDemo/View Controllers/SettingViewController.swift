//
//  SettingViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 7/30/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseStorage
import SwiftKeychainWrapper
import Firebase

class SettingViewController: UIViewController{
    @IBOutlet   weak var email: UITextField!
    @IBOutlet weak var signout: UIButton!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var School: UITextField!
    @IBOutlet weak var  userImage: UIImageView!
    var delegate: homeControllerDelegate?
    override func viewDidLoad() {
        print("TESTING")
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        getChatsFromUser()
        configFields()
        configInfo()
        configNavigationBar()
        self.setUserImage()
    }
    func configInfo(){
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.layer.masksToBounds = true
        userImage.layer.borderWidth = 0
        let Gif = UIImage.gifImageWithName("source")
        userImage.image = Gif
        self.email.text = "EMAIL:   " + (Auth.auth().currentUser?.email)!.capitalizingFirstLetter()
    }
    func configFields(){
        Utilities.styleHollowButton(signout)
        Utilities.styleTextField(email)
        Utilities.styleTextField(name)
        Utilities.styleTextField(School)
        School.isEnabled = false
        name.isEnabled = false
        email.isEnabled = false
        
        
        
    }
    func getChatsFromUser() {
        print("hi")
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
            .getDocuments() { (querySnapshot, err) in
                print("hello")
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("ERRORXXXXXXXXXXXXXXXXXX\n\n\n\n\n")
                } else {
                    for document in querySnapshot!.documents {
                        print("WE DID IT BOIS\n\n\n\n\n\n\n\n")
                        print("\(document.documentID) => \(document.data())")
                        
                        var temp : String!
                        var temp1 : String!
                        var temp2 : String!
                        temp = document.get("firstname") as! String
                        temp1 = document.get("lastname") as! String
                        temp2 = document.get("schoolName") as! String
                        self.name.text = "NAME:  " + temp.capitalizingFirstLetter() + " " + temp1.capitalizingFirstLetter()
                        self.School.text = "SCHOOL: " + temp2
                        
                        
                        
                    }
                }
        }
    }
    func setUserImage(){
        var temp1 : String!
        temp1 = Auth.auth().currentUser!.uid
        
        let storageRef = Storage.storage().reference()
        // Create a reference to the file you want to download
        let riversRef = storageRef.child("images/\(temp1).jpg")

        riversRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) -> Void in
          if (error != nil) {
            print("FAIL")
            print(error)
          } else {
            print("SUCCESS")
            let myImage: UIImage! = UIImage(data: data!)
            self.userImage.image = myImage
          }
        }
        
        
        
        
        
        
        
        
    }
    @IBAction func logOut (_ sender: AnyObject) {
        do{
            try Auth.auth().signOut()
        }catch{
            print("not signed out")
        }
        print("SIGNED OUT")
        KeychainWrapper.standard.removeAllKeys()
        transitionToHome()
        
    }
    func transitionToHome(){
        let ContainerViewController = self.storyboard?.instantiateViewController(identifier: "starterVC") as? UINavigationController
        
        self.view.window?.rootViewController = ContainerViewController
        self.view.window?.makeKeyAndVisible()
        
        
    }
    @objc func handleDismiss() {
           dismiss(animated: true, completion: nil)
       }
    //helper function
    func configUi(){
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
        
    }
    @objc func handleMenuToggle(){
           delegate?.handleMenuToggle(forMenuOption: nil)
           
           
           
       }
       func configNavigationBar(){
           navigationController?.navigationBar .barTintColor = .clear
           navigationController?.navigationBar.barStyle = .black
           navigationController?.navigationBar.isTranslucent = true
           navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
           navigationController?.navigationBar.shadowImage = UIImage() 
           navigationItem.title = "Profile"
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
           
       }
    
    
}
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
