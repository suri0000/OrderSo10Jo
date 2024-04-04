//
//  PaymentStackView.swift
//  OrderSo10Jo
//
//  Created by 예슬 on 4/2/24.
//

import UIKit

class PaymentStackView: UIView {
   
   required init?(coder: NSCoder) {
      //xib를 사용하기 위해 필수로 사용해야하는 부분
      
      super.init(coder: coder)

      let identifier = String(describing: PaymentStackView.self)
      
      guard let view = UINib(nibName: identifier, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else{return}
      
      addSubview(view)
      view.frame = self.bounds
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   

   @IBAction func cancelButton(sender: UIButton) {
      
      //let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
      //스토리보드 가져오기
      
      //guard let viewController = storyboard?.instantiateViewController(withIdentifier: "Main") else { return }
      // MainView와 연결하기
      
      guard let viewController = findViewController() else { return }
      
      let alert = UIAlertController(title: "주문 취소하시겠습니까?", message: "리스트가 모두 삭제됩니다.", preferredStyle: .alert)
      let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
      // handler 인자에 주문 취소 시 구조체 Order를 초기화하는 동작 전달하기
      
      let close = UIAlertAction(title: "닫기", style: .destructive)
      
      alert.addAction(confirm)
      alert.addAction(close)
      
      viewController.present(alert, animated: true)
   }
   
   @IBAction func payButton(sender: UIButton) {
      
      //let storyboard: UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
      //스토리보드 가져오기
      
      //guard let viewController = storyboard?.instantiateViewController(withIdentifier: "Main") else { return }
      // MainView와 연결하기
      
      guard let viewController = findViewController() else { return }
      
      let alert = UIAlertController(title: "주문 완료!", message: "", preferredStyle: .actionSheet)
      let confirm = UIAlertAction(title: "확인", style: .destructive, handler: nil)
      // handler 인자에 주문 완료 후 수행할 내용 전달
      
      alert.addAction(confirm)
      
      viewController.present(alert, animated: true)
   }
}

extension UIView {
   func findViewController() -> UIViewController? {
      if let nextResponder = self.next as? UIViewController {
         return nextResponder
      }
      else if let nextResponder = self.next as? UIView {
         return nextResponder.findViewController()
      }
      else {
         return nil
      }
   }
}
   
