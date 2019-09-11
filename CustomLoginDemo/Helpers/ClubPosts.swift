//
//  ClubPosts.swift
//  CustomLoginDemo
//
//  Created by Michael Shea on 8/9/19.
//  Copyright © 2019 Christopher Ching. All rights reserved.
//

import Foundation

import UIKit
class ClubPosts{
    
    var name: String!
    var img: UIImage!
    var description: String!
    var clubID: String!
    var contact: String!
    var meetingDays: String!
    
    
    init(name: String, description: String, ID: String) {
        self.name = name
        self.description = description
        self.clubID = ID
    }
}
