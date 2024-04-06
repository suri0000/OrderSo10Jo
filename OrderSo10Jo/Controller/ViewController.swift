//
//  ViewController.swift
//  OrderSo10Jo
//
//  Created by 김광민 on 2024/04/01.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var orderTableView: UITableView!
  @IBOutlet weak var menuTableView: UITableView!
  @IBOutlet weak var paymentView: PaymentView!
   
   var data: [MenuData] = [MenuData(name: "아이스 아메리카노", price: 4700, image: .init(named: "americano")!, category: .coffee),
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setOrderTableView()
    
    menuTableView.delegate = self
    menuTableView.dataSource = self
    
    //테이블뷰 셀의 identify로 연결
    menuTableView.register(UINib(nibName: "MenuSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuSelectTableViewCell")
  }
  
  func setOrderTableView() {
    orderTableView.delegate = self
    orderTableView.dataSource = self
    
    let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
    orderTableView.register(nib, forCellReuseIdentifier: OrderTableViewCell.cellID)
    
    view.addSubview(orderTableView)
  }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == self.orderTableView {
      return OrderTableViewCell.orders.count
    } else {
       return data.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == self.orderTableView {
      let cell = orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as! OrderTableViewCell
      
      cell.setOrderTableViewCell(indexPath: indexPath)
      cell.delegate = self
      
      return cell
      
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuSelectTableViewCell.identifier, for: indexPath) as? MenuSelectTableViewCell else { return UITableViewCell() }
      
      // 셀 설정
//      let menuItem = categoryData[indexPath.row]
//      cell.drinkName.text = menuItem.name
//      cell.drinkImage.image = menuItem.image
//      cell.drinkCost.text = String(menuItem.price)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == orderTableView {
      orderTableView.deselectRow(at: indexPath, animated: true)
    } else {
      menuTableView.deselectRow(at: indexPath, animated: true)
      
      let selectedMenu = data[indexPath.row]
      if let existingOrderIndex = OrderTableViewCell.orders.firstIndex(where: { $0.name == selectedMenu.name }) {
        OrderTableViewCell.orders[existingOrderIndex].count += 1
      } else {
        OrderTableViewCell.orders.append(Order(name: selectedMenu.name, price: selectedMenu.price, count: 1))
      }
       paymentView.calSelectedMenu()
       
      orderTableView.reloadData()
    }
  }
  
}

// OrderTableView 버튼 관련
extension ViewController: OrderTableViewCellDelegate {
  func deleteMenu(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders.remove(at: indexPath.row)
    orderTableView.deleteRows(at: [indexPath], with: .left)
     
     paymentView.calSelectedMenu()
  }
  
  func subtractOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders[indexPath.row].count -= 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    if OrderTableViewCell.orders[indexPath.row].count <= 1 {
      cell.minusButton.isEnabled = false
    }
     
     paymentView.calSelectedMenu()
  }
  
  func addOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
   
    OrderTableViewCell.orders[indexPath.row].count += 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    cell.minusButton.isEnabled = true
     
     paymentView.calSelectedMenu()
  }
  
}
