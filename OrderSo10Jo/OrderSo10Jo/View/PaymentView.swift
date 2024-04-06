//
//  PaymentView.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/2/24.
//

import UIKit

class PaymentView: UIView {
   
   @IBOutlet weak var totalSelectedCount: UILabel! //최종 선택된 상품 개수
   @IBOutlet weak var totalSelectedPrice: UILabel! //최종 선택된 상품 가격 합계
   
   required init?(coder: NSCoder) {
      //xib를 사용하기 위해 필수로 사용해야하는 부분
      
      super.init(coder: coder)
      
      let identifier = String(describing: PaymentView.self)
      
      guard let view = UINib(nibName: identifier, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else{ return }
      //instantiate 부분에서  Thread 1: EXC_BAD_ACCESS (code=2, address=0x16ea87f80) 발생!!!
      
      view.backgroundColor = .systemGray5
      
      addSubview(view)
      view.frame = self.bounds

      calSelectedMenu()
   }

   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   func calSelectedMenu() {
      var sumCount : Int = 0
      var sumPrice : Int = 0
      
      //print(OrderTableViewCell.orders)
      
      for i in OrderTableViewCell.orders {
         sumCount += i.count
         sumPrice += i.price * i.count
         
         //print(i.count, i.price)
      }
      totalSelectedCount.text = String(sumCount) + "개"
      totalSelectedPrice.text = String(sumPrice) + "원"
   }
}
