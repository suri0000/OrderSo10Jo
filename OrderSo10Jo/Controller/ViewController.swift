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
  
  var data: [MenuData] = [MenuData(name: "A", price: 6000, image: .init(named: "cafemoca")!, category: "커피"),
                          MenuData(name: "B", price: 5500, image: .init(named: "cafemoca")!, category: "커피"),
                          MenuData(name: "C", price: 5000, image: .init(named: "cafemoca")!, category: "음료"),
                          MenuData(name: "D", price: 4500, image: .init(named: "cafemoca")!, category: "음료"),
                          MenuData(name: "E", price: 4000, image: .init(named: "cafemoca")!, category: "디저트")
  ]
  
  let cellSpacingHeight: CGFloat = 1
  
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
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return cellSpacingHeight
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if tableView == self.orderTableView {
      let cell = orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as! OrderTableViewCell
      
      cell.setOrderTableViewCell(indexPath: indexPath)
      cell.delegate = self
      
      return cell
      
    } else {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuSelectTableViewCell.identifier, for: indexPath) as? MenuSelectTableViewCell else { return UITableViewCell() }
      
      cell.drinkName.text = data[indexPath.row].name
      cell.drinkImage.image = data[indexPath.row].image
      cell.drinkCost.text = String(data[indexPath.row].price)
      
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
      }  else {
        OrderTableViewCell.orders.append(Order(name: selectedMenu.name, price: selectedMenu.price, count: 1))
      }
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
  }
  
  func subtractOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders[indexPath.row].count -= 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    if OrderTableViewCell.orders[indexPath.row].count <= 1 {
      cell.minusButton.isEnabled = false
    }
  }
  
  func addOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders[indexPath.row].count += 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    cell.minusButton.isEnabled = true
  }
  
}
