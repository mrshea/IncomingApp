//
//  MenuOption.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 7/30/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//
import UIKit
enum MenuOption: Int, CustomStringConvertible{
    var description: String{
        switch self {
        case .Profile: return "Profile"
        case .Organizations: return "Orgs"
        case .Notifications: return "Notification"
        case .Settings: return "Settings"
        }
        
        
        
    }
    
    var image: UIImage{
        switch self {
        case .Profile: return UIImage(named: "ic_person_outline_white_2x") ?? UIImage()
        case .Organizations: return UIImage(named: "ic_mail_outline_white_2x") ?? UIImage()
        case .Notifications: return UIImage(named: "ic_menu_white_3x") ?? UIImage()
        case .Settings: return UIImage(named: "baseline_settings_white_24dp") ?? UIImage()
        }
        
        
        
    }

    case Profile
    case Organizations
    case Notifications
    case Settings
    
    
    
    
}
