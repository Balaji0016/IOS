//
//  ConstantClass.swift
//  PetFit
//
//  Created by Balaji U on 16/02/21.
//  Copyright © 2021 Balaji U. All rights reserved.
//

import Foundation
import UIKit

class UserData
{
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Constants{
    
    struct Storyboard{
       static let UsersHomevc = "UserHomeVC"
    }
    
}

struct tableData
{
    let name: String
    let image: String
    let DOB: String
    let location: String
    let breed: String
    
}

struct schduleData
{
    let date: String
    let activity: String
    
}

struct BuyProductData
{
    let name: String
    let price: String
    let image: String
}

struct FeedbackData {
    let date: String
    let name: String
    let details: String
    
}
