//
//  MenuSelectTableViewCell.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/1/24.
//

import UIKit

class MenuSelectTableViewCell: UITableViewCell {

    //타입 프로퍼티 변수 추가로 테이블뷰 셀의 identifier을 지정
    static let identifier = "MenuSelectTableViewCell"
    
    @IBOutlet weak var drinkImage: UIImageView!
    
    @IBOutlet weak var drinkName: UILabel!
    
    @IBOutlet weak var drinkCost: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
