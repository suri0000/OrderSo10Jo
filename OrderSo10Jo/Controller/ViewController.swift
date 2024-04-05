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
  let segmentControlView = SegmentView()
  
  var data: [MenuData] = [MenuData(name: "A", price: 6000, image: .init(named: "cafemoca")!, category: .coffee),
                          MenuData(name: "B", price: 5500, image: .init(named: "cafemoca")!, category: .coffee),
                          MenuData(name: "C", price: 5000, image: .init(named: "cafemoca")!, category: .juice),
                          MenuData(name: "D", price: 4500, image: .init(named: "cafemoca")!, category: .juice),
                          MenuData(name: "E", price: 4000, image: .init(named: "cafemoca")!, category: .dessert),
                          MenuData(name: "마이버디 춘식이 코나 텀블러", price: 30000, image: .init(named: "md")!, category: .merchandise)
  ]
  
  var filteredMenuData: [MenuData] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setOrderTableView()
    
    menuTableView.delegate = self
    menuTableView.dataSource = self
    
    //테이블뷰 셀의 identify로 연결
    menuTableView.register(UINib(nibName: "MenuSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuSelectTableViewCell")
    
    SegmentView.delegate = self
    view.addSubview(segmentControlView)
  }
  
  func setOrderTableView() {
    orderTableView.delegate = self
    orderTableView.dataSource = self
    
    let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
    orderTableView.register(nib, forCellReuseIdentifier: OrderTableViewCell.cellID)
    
    view.addSubview(orderTableView)
  }
  
  func filterCategory(category: Categories) -> [MenuData] {
    filteredMenuData = data.filter { $0.category == category }
    return filteredMenuData
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == self.orderTableView {
      return OrderTableViewCell.orders.count
    } else {
      switch SegmentView.segmentControl.selectedSegmentIndex {
        case 0:
          return filterCategory(category: .coffee).count
        case 1:
          return filterCategory(category: .juice).count
        case 2:
          return filterCategory(category: .dessert).count
        case 3:
          return filterCategory(category: .merchandise).count
        default:
          return data.count
      }
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
      
      let categoryData: [MenuData]
      switch SegmentView.segmentControl.selectedSegmentIndex {
        case 0:
          categoryData = filterCategory(category: .coffee)
        case 1:
          categoryData = filterCategory(category: .juice)
        case 2:
          categoryData = filterCategory(category: .dessert)
        case 3:
          categoryData = filterCategory(category: .merchandise)
        default:
          categoryData = data
      }
      
      // 셀 설정
      let menuItem = categoryData[indexPath.row]
      cell.drinkName.text = menuItem.name
      cell.drinkImage.image = menuItem.image
      cell.drinkCost.text = String(menuItem.price)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if tableView == orderTableView {
      orderTableView.deselectRow(at: indexPath, animated: true)
    } else {
      menuTableView.deselectRow(at: indexPath, animated: true)
      
      let selectedCategory: Categories
      switch SegmentView.segmentControl.selectedSegmentIndex {
        case 0:
          selectedCategory = .coffee
        case 1:
          selectedCategory = .juice
        case 2:
          selectedCategory = .dessert
        case 3:
          selectedCategory = .merchandise
        default:
          selectedCategory = .coffee
      }
      
      let categoryData = filterCategory(category: selectedCategory)
      let selectedMenu = categoryData[indexPath.row]
      if let existingOrderIndex = OrderTableViewCell.orders.firstIndex(where: { $0.name == selectedMenu.name }) {
        OrderTableViewCell.orders[existingOrderIndex].count += 1
      } else {
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

extension ViewController: SegmentViewDelegate {
  func segmentView(_ segmentView: SegmentView, didSelectSegmentAt index: Int) {
    menuTableView.reloadData()
  }
}
