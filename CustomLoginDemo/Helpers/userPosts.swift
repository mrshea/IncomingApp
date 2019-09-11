//
//  document.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/4/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage



class userPosts{
    
    var name: String!
    var img: UIImage!
    var text: String!
    var userID: String!
    var postID: String!
    var numImages: String!
    
    var image1:UIImage!
    var image2:UIImage!
    var image3:UIImage!
    
    
    
    
    init(name: String, text: String, ID: String, postID: String, numImages: String) {
        self.name = name
        self.text = text
        self.userID = ID
        self.postID = postID
        self.numImages = numImages
    }
    
    
    func getAllPost(completion: @escaping () -> Void){
        switch numImages {
            
        case "0":
            completion()
        case "1":
            getPostImage(postID: self.postID, fileName: "image1.jpeg") { (image) in
                self.image1 = image
                completion()
            }
            
        case "2":
            getPostImage(postID: self.postID, fileName: "image1.jpeg") { (image) in
                self.image1 = image
                self.getPostImage(postID: self.postID, fileName: "image2.jpeg") { (image) in
                    self.image2 = image
                    completion()
                }
            }
        case "3":
            getPostImage(postID: self.postID, fileName: "image1.jpeg") { (image) in
                self.image1 = image
            
                self.getPostImage(postID: self.postID, fileName: "image2.jpeg") { (image) in
                    self.image2 = image
            
                    self.getPostImage(postID: self.postID, fileName: "image3.jpeg") { (image) in
                        self.image3 = image
                        completion()
                    }
                }
            }
        default:
            break
        }

        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getPostImage(postID: String, fileName: String, completion: @escaping (UIImage) -> Void){
        var temp1 : String!
        temp1 = Auth.auth().currentUser!.uid
    
        let storageRef = Storage.storage().reference()
    // Create a reference to the file you want to download
        //globalUserSchoolCode = "0001"
        print(globalUserSchoolCode)
        print(self.postID)
        print(fileName)
        
        let riversRef = storageRef.child("\(globalUserSchoolCode!)/post/\(String(describing: self.postID))/\(fileName)")
        var myImage: UIImage!
        riversRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) -> Void in
        if (error != nil) {
            print("FAIL")
            print(error)
            completion(myImage)
        } else {
            print("got post image")
            myImage = UIImage(data: data!)
            //self.userImage.image = myImage
            completion(myImage)
            }
    }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
