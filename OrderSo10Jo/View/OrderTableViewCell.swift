//
//  OrderTableViewCell.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/1/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
  
  
  @IBOutlet weak var menuName: UILabel!
  static var orderList = [Order(name: "아메리카노", price: 4500, count: 2),
                   Order(name: "카페라떼", price: 5000, count: 1)]
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func setOrderTableViewCell(indexPath: IndexPath) {
    menuName?.text = OrderTableViewCell.orderList[indexPath.row].name
  }
    
}
