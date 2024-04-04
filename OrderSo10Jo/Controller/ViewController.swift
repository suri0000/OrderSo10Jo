//
//  ViewController.swift
//  OrderSo10Jo
//
//  Created by 김광민 on 2024/04/01.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var TitleView: UIView!
   @IBOutlet weak var paymentStackView: PaymentStackView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      TitleView.backgroundColor = .green
      
   }
   

}

