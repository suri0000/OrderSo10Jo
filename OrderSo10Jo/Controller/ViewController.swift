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
  
    
    
    @IBOutlet weak var MenuTableView: UITableView!
    
    
    var data: [MenuData] = [MenuData(name: "A", price: 6000, image: .init(named: "cafemoca")!, category: "커피"),
                            MenuData(name: "B", price: 6000, image: .init(named: "cafemoca")!, category: "커피"),
                            MenuData(name: "C", price: 6000, image: .init(named: "cafemoca")!, category: "커피")
    ]
    let cellSpacingHeight: CGFloat = 1
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setOrderTableView()
      
      MenuTableView.delegate = self
      MenuTableView.dataSource = self
      
      //테이블뷰 셀의 identify로 연결
      MenuTableView.register(UINib(nibName: "MenuSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuSelectTableViewCell")
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
      if tableView == self.orderTableView{
          return orderList.count
      } else {
          return data.count
      }
      }
  
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
        }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      if tableView == self.orderTableView{
          let cell = orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as! OrderTableViewCell
          
          cell.setOrderTableViewCell(indexPath: indexPath)
          cell.delegate = self
          
          return cell
          
      }else {
          
          guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuSelectTableViewCell.identifier, for: indexPath) as? MenuSelectTableViewCell else {return UITableViewCell() }
          
          cell.DrinkName.text = data[indexPath.row].name
          cell.DrinkImage.image = data[indexPath.row].image
          cell.DrinkCost.text = String(data[indexPath.row].price)
          
          
          return cell
      }
  
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



