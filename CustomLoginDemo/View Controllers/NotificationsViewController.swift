//
//  ProfileViewControllee.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 7/31/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit


class NotificationViewController: UIViewController{
   var delegate: homeControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configNavigationBar()
    }
    @objc func handleDismiss() {
           dismiss(animated: true, completion: nil)
       }
    //helper function
    func configUi(){
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_clear_white_36pt_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
        
        
    }
    @objc func handleMenuToggle(){
           delegate?.handleMenuToggle(forMenuOption: nil)
           
           
           
       }
       func configNavigationBar(){
           navigationController?.navigationBar .barTintColor = .darkGray
           navigationController?.navigationBar.barStyle = .black
           navigationItem.title = "Side Menu"
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
           
       }
    
    
}
