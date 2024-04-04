//
//  ViewController.swift
//  OrderSo10Jo
//
//  Created by 김광민 on 2024/04/01.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var orderTableView: UITableView!
  
  var orderList = OrderTableViewCell.orders
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setOrderTableView()
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
    return orderList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as! OrderTableViewCell
    
    cell.setOrderTableViewCell(indexPath: indexPath)
    cell.delegate = self
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    orderTableView.deselectRow(at: indexPath, animated: true)
  }
  
}

extension ViewController: OrderTableViewCellDelegate {
  func deleteMenu(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    orderList.remove(at: indexPath.row)
    orderTableView.deleteRows(at: [indexPath], with: .left)
  }
  
  
  func subtractOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    orderList[indexPath.row].count -= 1
    cell.orderQuantity.text = String(orderList[indexPath.row].count)
    if orderList[indexPath.row].count <= 1 {
      cell.minusButton.isEnabled = false
    }
  }
  
  func addOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    orderList[indexPath.row].count += 1
    cell.orderQuantity.text = String(orderList[indexPath.row].count)
    cell.minusButton.isEnabled = true
  }
  
}

