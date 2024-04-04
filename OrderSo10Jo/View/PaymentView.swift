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
      
      addSubview(view)
      view.frame = self.bounds
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   var ordersList = [Order(name: "아메리카노", price: 4500, count: 2),
                     Order(name: "복자 요가 프라페", price: 5900, count: 1)]
   // 건응님 데이터 불러오기 한 다음 다시 작업할 것
   
   func calSelectedCount() {
      var sumCount : Int = 0
      
      for i in ordersList {
         sumCount += i.count
      }
      totalSelectedCount.text = String(sumCount)
   }
   
   func calSelectedPrice() {
      var sumPrice : Int = 0
      
      for i in ordersList {
         sumPrice += i.price
      }
      totalSelectedPrice.text = String(sumPrice)
   }
}
