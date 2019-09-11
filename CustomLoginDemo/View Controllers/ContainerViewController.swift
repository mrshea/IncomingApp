//
//  ContainerViewController.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 7/30/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation
import UIKit

var globalUserImage: UIImage!
var globalUserName: String!
var globalUserSchool: String!
var globalUserSchoolCode: String!



class ContainerViewController: UIViewController {
    //properties
    var menuController: MenuViewController!
    var centerController: UIViewController!
    var isExpanded = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHomeController()
        
        
        
        
        
        //configMenuController()
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    override var prefersStatusBarHidden: Bool {
           return isExpanded
       }
    
    
    
    func configHomeController(){
        let homeController = self.storyboard?.instantiateViewController(identifier: "home") as? HomeViewController
        homeController!.delegate = self
        //homeController?.view.backgroundColor = .lightGray
        centerController = UINavigationController(rootViewController: homeController!)
        
        
        
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self )
        
        

        
    }
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?){
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        }else{
            // hide menu
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
            animateStatusBar()
        }
        
        
        
        
    }
    
    
    func didSelectMenuOption(menuOption: MenuOption){
        centerController.view.removeFromSuperview()
        
        switch menuOption {
        case .Profile:
            configHomeController()
        case .Organizations:
             let homeController = storyboard?.instantiateViewController(identifier: "clubVC") as? ClubsViewController
                       //homeController?.delegate = self
                       centerController = UINavigationController(rootViewController: homeController!)
                       
                       view.addSubview(centerController.view)
                       addChild(centerController)
                       centerController.didMove(toParent: self )
                       
        case .Settings:
            
             let homeController = storyboard?.instantiateViewController(identifier: "settings") as? SettingViewController
                       homeController?.delegate = self
                       centerController = UINavigationController(rootViewController: homeController!)
                       
                       view.addSubview(centerController.view)
                       addChild(centerController)
                       centerController.didMove(toParent: self )
                       
            
            
            
            
    
        case .Notifications:
            
             let homeController = storyboard?.instantiateViewController(identifier: "settings") as? SettingViewController
                       homeController?.delegate = self
                       centerController = UINavigationController(rootViewController: homeController!)
                       
                       view.addSubview(centerController.view)
                       addChild(centerController)
                       centerController.didMove(toParent: self )
                       
        }
        
        
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    
    
    
    func configMenuController(){
       if menuController == nil {
            menuController = MenuViewController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)

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
extension ContainerViewController: homeControllerDelegate{
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        
        if !isExpanded{
            configMenuController()
        }
            isExpanded = !isExpanded
            animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
    
    
    
    
    
    
}
