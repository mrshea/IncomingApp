//
//  ImagePickerViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/1/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage



class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectButton: UIButton!
    
    let imagePicker = UIImagePickerController()
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //databaseRef = FIRDatabase.database().reference()
        print("hello")
        imagePicker.delegate = self
      
    }
    @IBAction func upload (_ sender: AnyObject) {
        let storageRef = Storage.storage().reference()
        
        
        
        let data = imageView.image?.jpeg(.low)
        // Create a reference to the file you want to upload
        
        
        var temp1 : String!
        temp1 = Auth.auth().currentUser!.uid
        let riversRef = storageRef.child("images/\(temp1).jpg")

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(data!, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          let size = metadata.size
          // You can also access to download URL after upload.
          storageRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
            
            
            
            
          }
        }
    transitionToHome()
    
    }
    func transitionToHome(){
        let ContainerViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.ContainerViewController) as? ContainerViewController
                           
        self.view.window?.rootViewController = ContainerViewController
        self.view.window?.makeKeyAndVisible()
        
        
    }
    @IBAction func getPhoto (_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
        
        
        
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
//            var cropRect = CGRect(x: 0.0, y: 0.0, width: 125, height: 125)
//            let cutImageRef: CGImage = (pickedImage.cgImage?.cropping(to: cropRect))!
//            let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
            
            selectButton.setTitle("",for: .normal)
            imageView.contentMode = .scaleAspectFill
            imageView.image = pickedImage
        }
     
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

