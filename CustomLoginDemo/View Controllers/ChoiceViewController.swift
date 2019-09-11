//
//  ChoiceViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 7/31/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper
import Firebase
import FirebaseStorage
class ChoiceViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
   
          
    }
    override func viewDidAppear(_ animated: Bool) {
        checkIfLoggedIn()
    }
    func checkIfLoggedIn(){
        
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            self.getinfoFromUser {
                self.setUserImage {
                    let ContainerViewController = self.storyboard?.instantiateViewController(identifier: "Container") as? ContainerViewController
                    
                    self.view.window?.rootViewController = ContainerViewController
                    self.view.window?.makeKeyAndVisible()
                }
            }
            
            
            
        }else{
            let ContainerViewController = self.storyboard?.instantiateViewController(identifier: "starterVC") as? UINavigationController
            
            self.view.window?.rootViewController = ContainerViewController
            self.view.window?.makeKeyAndVisible()
            
        }
        
        
        
        
    }
    func getinfoFromUser(completion: @escaping () -> Void) {
        print("hi")
        let db = Firestore.firestore()
        db.collection("users").whereField("uid", isEqualTo: String(describing: Auth.auth().currentUser!.uid))
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    print("ERRORXXXXXXXXXXXXXXXXXX\n\n\n\n\n")
                    completion()
                } else {
                    for document in querySnapshot!.documents {
                        
                        print("\(document.documentID) => \(document.data())")
                        
                        var temp : String!
                        var temp1 : String!
                        var temp2 : String!
                        var temp3 : String!
                        temp = document.get("firstname") as! String
                        temp1 = document.get("lastname") as! String
                        temp2 = document.get("schoolName") as! String
                        temp3 = document.get("schoolCode") as! String
                        globalUserName = temp.capitalizingFirstLetter() + " " + temp1.capitalizingFirstLetter()
                        globalUserSchool = temp2
                        globalUserSchoolCode = temp3
                        completion()
                        
                    }
                }
        }
    }
    func setUserImage(completion: @escaping () -> Void){
        var temp1 : String!
        temp1 = Auth.auth().currentUser!.uid
        
        let storageRef = Storage.storage().reference()
        // Create a reference to the file you want to download
        let riversRef = storageRef.child("images/\(temp1).jpg")

        riversRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) -> Void in
          if (error != nil) {
            print("FAIL")
            print(error)
            completion()
          } else {
            print("Got User Image")
            let myImage: UIImage! = UIImage(data: data!)
            globalUserImage = myImage
            completion()
          }
        }
        
        
        
        
        
        
        
        
    }
    


}

