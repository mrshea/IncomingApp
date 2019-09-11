//
//  ClubsViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/9/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import UIKit

class ClubsViewController: UITableViewController {
    
    var post = [ClubPosts]()
    var delegate: homeControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        getClubs()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 400
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        tableView.reloadData()
        

        // Do any additional setup after loading the view.
    }
    func getClubs(){
        
        post.append(ClubPosts(name: "association For Computer Machinist", description: "the best club on campus", ID: "0000000"))
        
        
        
        
        
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
    @objc func handleMenuToggle(){
           delegate?.handleMenuToggle(forMenuOption: nil)
           
           
           
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
extension ClubsViewController{
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400 
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "clubCell", for: indexPath) as! ClubTableViewCell
               
               
               
               cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
               cell.textLabel1!.text = post[indexPath.row].description
               cell.nameLabel!.text = post[indexPath.row].name
               cell.userID = post[indexPath.row].clubID
               cell.getimage()
               cell.contentView.layer.addBorder(edge: .top, color: .lightGray, thickness: 10)
               print("hi")
               //cell.frame = cell.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
               print("what up")

               return cell
    }
    




    
    
    
    


}




