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
  
  static var data: [MenuData] = [MenuData(name: "아이스 아메리카노", price: 4700, image: .init(named: "americano")!, category: .coffee),
                          MenuData(name: "아이스 카페라떼", price: 5700, image: .init(named: "cafelatte")!, category: .coffee),
                          MenuData(name: "카페 모카", price: 6200, image: .init(named: "cafemoca")!, category: .coffee),
                          MenuData(name: "바닐라라떼", price: 6200, image: .init(named: "banilalatte")!, category: .coffee),
                          MenuData(name: "에스프레소", price: 4400, image: .init(named: "espresso")!, category: .coffee),
                          MenuData(name: "마이버디 춘식이 코나 텀블러", price: 48000, image: .init(named: "md")!, category: .merchandise),
                          MenuData(name: "아이스 제주 말차 라떼", price: 6000, image: UIImage(named: "matchalatte")!, category: .juice),
                          MenuData(name: "블루베리 식혜", price: 5500, image: UIImage(named: "blueberry")!, category: .juice),
                          MenuData(name: "플레인 베이글", price: 3300, image: UIImage(named: "bagle")!, category: .dessert),
                          MenuData(name: "피칸파이", price: 7000, image: UIImage(named: "pecanpie")!, category: .dessert),
                          MenuData(name: "바리스타춘식 DW 투고 텀블러", price: 54000, image: UIImage(named: "togo")!, category: .merchandise),
                          MenuData(name: "마이버디 춘식이 키체인", price: 18000, image: UIImage(named: "keychain")!, category: .merchandise),
                          MenuData(name: "오렌지 쥬스", price: 5500, image: UIImage(named: "orangejuice")!, category: .juice),
                          MenuData(name: "말차 스무디", price: 6600, image: UIImage(named: "smoody")!, category: .juice),
                          MenuData(name: "딸기 케이크", price: 7000, image: UIImage(named: "strawberrycake")!, category: .dessert),
                          MenuData(name: "마이버디 패브릭 코스터 세트", price: 27000, image: UIImage(named: "coster")!, category: .merchandise),
                          MenuData(name: "레드벨벳 케익", price: 6800, image: UIImage(named: "redvelvetcake")!, category: .dessert)
  ]
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

