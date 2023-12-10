//
//  ProductModel.swift
//  MVVM IOS
//
//  Created by Shashank Pandey on 10/12/23.
//

import Foundation

struct ProductModal:Decodable{
    let id:Int?
    let title:String?
    let price:Double?
    let description:String?
    let category:String?
    let image:String?
}

