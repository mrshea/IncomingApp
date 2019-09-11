//
//  PostViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/6/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import Firebase



class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postText: UITextView!
    
    @IBOutlet weak var image1View: UIImageView!
    @IBOutlet weak var image2View: UIImageView!
    @IBOutlet weak var image3View: UIImageView!
    
    
    @IBOutlet weak var image1Button: UIButton!
    @IBOutlet weak var image2Button: UIButton!
    @IBOutlet weak var image3Button: UIButton!
   
    var sender: Int!
    var postID: String!
    
    let imagePicker = UIImagePickerController()
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
        // Do any additional setup after loading the view.
    }
    func config(){
        
        postText.returnKeyType = .done
        postText.delegate = self
        
        
        image2View.isHidden = true
        image2Button.isHidden = true

        image3Button.isHidden = true
        image3View.isHidden = true
        
        
        
        imagePicker.delegate = self
        userImage.image = globalUserImage
        userNameLabel.text = globalUserName
        userImage.contentMode = .scaleAspectFill
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        userImage.layer.masksToBounds = true
        userImage.layer.borderWidth = 0
        
        
        
        
    }
    
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
    
    
    
    
    @IBAction func post(_ sender: Any) {
        let db = Firestore.firestore()
        let date = 0 - Date().timeIntervalSince1970
        var ref: DocumentReference? = nil
        ref = db.collection(globalUserSchoolCode).addDocument(data: ["post": postText!.text, "User ID": Auth.auth().currentUser!.uid, "name": globalUserName,"date": date, "numImages": getNumPhotos()]) { (error) in
            self.postID = ref?.documentID
            self.uploadPhoto()
            if error != nil {
                // Show error message
                print("Error saving user data")
            }
        }
        
        
        
        
        
    }
    func getNumPhotos() -> String{
        
        var value = "0"
        
        if image1View.image != nil{
            value = "1"
            if image2View.image != nil{
               value = "2"
                if image3View.image != nil{
                    value = "3"
                }
            }
        }
        
        return value
        
    }
    
    
    
    func uploadPhoto(){
        if image1View.image != nil{
            self.uploadPhoto(image: image1View.image!, fileName: "image1.jpeg")
            if image2View.image != nil{
                self.uploadPhoto(image: image2View.image!, fileName: "image2.jpeg")
                if image3View.image != nil{
                    self.uploadPhoto(image: image3View.image!, fileName: "image3.jpeg")
                }
            }
        }
        
        
        
    }
    func uploadPhoto(image: UIImage, fileName: String){
        
        
        
        let storageRef = Storage.storage().reference()
        
        
        
        let data = image.jpeg(.low)
        let riversRef = storageRef.child("\(globalUserSchoolCode!)/post/\(postID)/\(fileName)")
        
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
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    @IBAction func getPhoto (_ sender: UIButton) {
        
        self.sender = sender.tag
        
        
        
        
        
        imagePicker.modalPresentationStyle = .overCurrentContext
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
            
        present(imagePicker, animated: true, completion: nil)
        
        
        
        
        
    }
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
            print("sender \(self.sender!)")
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
               
                
                switch self.sender!
                {
                    case 1:
                        //when Button1 is clicked...
                        print("testing")
                        image1Button.setTitle("",for: .normal)
                        image1Button.backgroundColor = .clear
                        image1View.contentMode = .scaleAspectFill
                        image1View.image = pickedImage
                        
                        image2View.isHidden = false
                        image2Button.isHidden = false
                        
                        
                        
                        
                        break
                    case 2: print("2")
                        //when Button2 is clicked...
                        image2Button.setTitle("",for: .normal)
                        image2Button.backgroundColor = .clear
                        image2View.contentMode = .scaleAspectFill
                        image2View.image = pickedImage
                        image3View.isHidden = false
                        image3Button.isHidden = false
                        break
                    case 3: print("3")
                        //when Button3 is clicked...
                        image3Button.setTitle("",for: .normal)
                        image3Button.backgroundColor = .clear
                        image3View.contentMode = .scaleAspectFill
                        image3View.image = pickedImage
                        break
                    default: print("Other...")
                }
                
                
                
                
                
                
                
                
                
                
                
            }
         
            dismiss(animated: true, completion: nil)
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    
    

}
extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
