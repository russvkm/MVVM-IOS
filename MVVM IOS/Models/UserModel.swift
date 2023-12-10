//
//  UserModel.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation
struct UserModel:Decodable{
    let address:Address?
    let username:String?
    let email:String?
}

struct Address:Decodable{
    let city:String?
}
