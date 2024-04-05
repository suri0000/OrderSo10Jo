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
}

enum Categories {
    case coffee
    case juice
    case dessert
    case merchandise
}

