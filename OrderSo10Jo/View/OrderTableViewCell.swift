//
//  OrderTableViewCell.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/1/24.
//

import UIKit

protocol OrderTableViewCellDelegate {
  func addOrderQuantity(for cell: OrderTableViewCell)
}

class OrderTableViewCell: UITableViewCell {
  
  @IBOutlet weak var menuName: UILabel!
  @IBOutlet weak var minusButton: UIButton!
  @IBOutlet weak var plusButton: UIButton!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var orderQuantity: UILabel!
  
  static var orders = [Order(name: "아메리카노", price: 4500, count: 2),
                       Order(name: "복자 요거트 프라페", price: 5000, count: 1)]
  var orderList = OrderTableViewCell.orders
  
  var delegate: OrderTableViewCellDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  
  @IBAction func plusButtonTapped(_ sender: Any) {
    delegate?.addOrderQuantity(for: self)
  }
  
  func setOrderTableViewCell(indexPath: IndexPath) {
    menuName?.text = OrderTableViewCell.orders[indexPath.row].name
    orderQuantity.text = String(orderList[indexPath.row].count)
  }
  
}
