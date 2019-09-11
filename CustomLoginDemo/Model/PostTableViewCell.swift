//
//  PostTableViewCell.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/4/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLabel1: UILabel?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    
    
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var imageViewHieght: NSLayoutConstraint!
    
    var userID: String!
    var postID: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        //pic1.image = UIImage.gifImageWithName("source")
       
        
        
        
        
//        pic1.removeFromSuperview()
        
        //pic1.frame = CGRect(x: pic1.frame.origin.x, y: pic1.frame.origin.y, width: 400, height: 400)
        //pic1.heightAnchor.constraint(equalToConstant: 100)
        
        
        textLabel1?.numberOfLines = 0
        textLabel1?.lineBreakMode = .byWordWrapping
        imageView1.contentMode = .scaleAspectFill
        imageView1.layer.cornerRadius = imageView1.frame.size.height/2
        imageView1.layer.masksToBounds = true
        imageView1.layer.borderWidth = 0
        
        pic1.contentMode = .scaleAspectFill
        pic2.contentMode = .scaleAspectFill
        pic3.contentMode = .scaleAspectFill
        //imageView1.layer.cornerRadius = imageView1.frame.size.height/2
        //imageView1.layer.masksToBounds = true
        //imageView1.layer.borderWidth = 0
        
        
        
        
        
        
        // Initialization code
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        //set the values for top,left,bottom,right margins
//        let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        contentView.frame = contentView.frame.inset(by: margins)
//    }

    func getimage(){
        let storageRef = Storage.storage().reference()
                           // Create a reference to the file you want to download
                           let riversRef = storageRef.child("images/\(userID).jpg")

                           riversRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) -> Void in
                             if (error != nil) {
                               print("Could Not Get Image")
                               print(error)
                             } else {
                               print("SUCCESS")
                               let myImage: UIImage! = UIImage(data: data!)
                                self.imageView1.image = myImage
                               //self.tableView.reloadData()
                             }
                           }
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
