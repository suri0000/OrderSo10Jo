//
//  ViewController.swift
//  OrderSo10Jo
//
//  Created by 김광민 on 2024/04/01.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var orderTableView: UITableView!
  
  var orderList = OrderTableViewCell.orderList

//  static var orderList = [Order(name: "아메리카노", price: 4500, count: 2),
//                   Order(name: "카페라떼", price: 5000, count: 1)]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setOrderTableView()
  }
  
  func setOrderTableView() {
    orderTableView.delegate = self
    orderTableView.dataSource = self
    
    let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
    orderTableView.register(nib, forCellReuseIdentifier: "OrderCell")
    
    view.addSubview(orderTableView)
  }
  
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return orderList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
    
    cell.setOrderTableViewCell(indexPath: indexPath)
    //cell.menuName?.text = orderList[indexPath.row].name
    
    return cell
  }
  
  
}

