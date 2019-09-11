//
//  HomeViewController.swift
//  CustomLoginDemo
//
//  Created by Christopher Ching on 2019-07-22.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    //properties
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    var delegate: homeControllerDelegate?
    let list = ["test1", "test2", "test3"]
    
    var currentCount: Int!
    
    var post = [userPosts]()
    var x = 0
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        //view.backgroundColor = .green
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)

        configNavigationBar()
        getPost()
        // Do any additional setup after loading the view.
    }
    
    @objc func handleMenuToggle(){
        delegate?.handleMenuToggle(forMenuOption: nil)
        
        
        
    }
    @objc private func refreshTableView(_ sender: Any) {
        // Fetch Weather Data
        reload()
    }
    private func reload() {
        self.x = 0
        self.currentCount = nil
        self.post.removeAll()
        self.tableView.reloadData()
        getPost()
        //self.updateView()
        
        
        self.refreshControl.endRefreshing()
        //self.activityIndicatorView.stopAnimating()
    }
    
    
    
    @objc func handleUploadToggle(){
        let modalViewController = self.storyboard?.instantiateViewController(identifier: "postVC") as? PostViewController
        modalViewController!.modalPresentationStyle = .overCurrentContext
        self.present(modalViewController!, animated: true, completion: nil)
        
        
    }
    
    func config(){
        
        
    }
    func configNavigationBar(){
        navigationController?.navigationBar .barTintColor = .clear
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "upload").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleUploadToggle))
        
    
    }
    func getImage(postID: String, fileName: String, completion: @escaping (UIImage) -> Void){
        var temp1 : String!
        temp1 = Auth.auth().currentUser!.uid
    
        let storageRef = Storage.storage().reference()
    // Create a reference to the file you want to download
        let riversRef = storageRef.child("\(globalUserSchoolCode!)/post/\(postID)\(fileName)")
        var myImage: UIImage!
        riversRef.getData(maxSize: 1 * 2048 * 2048) { (data, error) -> Void in
        if (error != nil) {
            print("FAIL")
            print(error)
            completion(myImage)
        } else {
            print("SUCCESS")
            myImage = UIImage(data: data!)
            //self.userImage.image = myImage
            completion(myImage)
            } 
    }
    }
    
    
    
    
    func getPost(){
        //post = [userPosts]()
        let db = Firestore.firestore()
        
        db.collection("0001").order(by: "date").getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)")
            }
            else
            {
                
                var difference = 0
                if self.currentCount != nil{
                   difference = querySnapshot!.count - self.currentCount!
                }
                print("snapshot count: \(querySnapshot!.count)")
                print("current count: \(self.currentCount)")
                var count = 0
                var addedCount = 0
                for document in querySnapshot!.documents {
                    
                    if (count < self.x + 10 + difference) && (count >= self.x + difference){
                    addedCount += 1
                    print("\(document.documentID) => \(document.data())")
                    
                    var temp1 : String!
                    temp1 = document.get("User ID") as! String
                    print("temp: " + temp1)
                    
                    print("DOC ID: \(document.documentID)")
                    let temp = userPosts(name: document.get("name") as! String, text: document.get("post") as! String, ID: temp1, postID: document.documentID, numImages: document.get("numImages") as! String)
                        
                        
                        
                        
                        //print("NUM IMG: \(temp.numImages)")
                   self.post.append(temp)
                   self.tableView.reloadData()
                }
                    
                 count += 1
                    
                
                    
                    
                }
                self.x += addedCount
                self.currentCount = count
                print("added = \(addedCount)")
                print("Count = \(count)")
                print("X = \(self.x)")
            }
        
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.post.count
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return tableView.cellForRow(at: indexPath)?.textLabel.
//    }

  
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == post.count {
            print("retrieving more data")
            getPost()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostTableViewCell
        
        if cell == nil{
            
            print("NIL")
        }
        
        cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        cell.textLabel1!.text = post[indexPath.row].text
        cell.nameLabel!.text = post[indexPath.row].name
        cell.userID = post[indexPath.row].userID
        cell.getimage()
        cell.contentView.layer.addBorder(edge: .top, color: .lightGray, thickness: 10)
        print("hi")
        //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
        
        getImages(cell: cell, post: post[indexPath.row])
        
        
        
        
        print("what up")

        return cell
    }
    func getImages(cell: PostTableViewCell, post: userPosts){
        
        
        
        print("NUM IMG2: \(post.numImages)")
        post.getAllPost {
        
        print("is this in the right place")
        
        switch post.numImages {
        case "0":
            print("NO IMAGES")
            cell.imageViewHieght.constant = 0
        case "1":
            print("one Image")
            cell.pic1.image = post.image1
        case "2":
            cell.pic1.image = post.image1
            cell.pic2.image = post.image2
        case "3":
            cell.pic1.image = post.image1
            cell.pic2.image = post.image2
            cell.pic3.image = post.image3
        default:
            break;
        }
        
        
        }
        
        
    }
    
    
    
}
extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }

        border.backgroundColor = color.cgColor;

        addSublayer(border)
    }
}
