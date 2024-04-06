//
//  OrderData.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/1/24.
//

import Foundation
import UIKit

struct MenuData {
  let name: String
  let price: Int
  let image: UIImage
   
   
   
  let category: Categories
}

struct Order {
  let name: String
  var price: Int
  var count: Int
  
//  static var orders = [Order(name: "아메리카노", price: 4500, count: 2),
//                       Order(name: "복자 요거트 프라페", price: 5000, count: 1)]
}

enum Categories {
    case coffee
    case juice
    case dessert
    case merchandise
}
