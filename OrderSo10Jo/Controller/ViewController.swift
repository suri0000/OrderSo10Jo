//
//  ViewController.swift
//  OrderSo10Jo
//
//  Created by 김광민 on 2024/04/01.
//

import UIKit

enum MenuCategory: Int {
    case coffee
    case juice
    case desert
    case other
}

class ViewController: UIViewController {

    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var titleView: TitleView!
    var data: [MenuData] = []{
        didSet {
            menuTableView.reloadData()
    }
}
  
  @IBOutlet weak var paymentView: PaymentView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    //setOrderTableView()
    
    menuTableView.delegate = self
    menuTableView.dataSource = self
    
    //테이블뷰 셀의 identify로 연결
    menuTableView.register(UINib(nibName: "MenuSelectTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuSelectTableViewCell")
      
    firstMenu()
    configureCategorySelectionAction()
  }
    
    func firstMenu() {
        
        switch titleView.segview.segmentControl.selectedSegmentIndex {
            case 0:
                // 커피
                data = [
                    MenuData(name: "아이스 아메리카노", price: 4700, image: .init(named: "americano")!, category: "커피"),
                    MenuData(name: "아이스 카페라떼", price: 4700, image: .init(named: "cafelatte")!, category: "커피"),
                    MenuData(name: "카페 모카", price: 5000, image: .init(named: "cafemoca")!, category: "커피"),
                    MenuData(name: "바닐라 라떼", price: 5500, image: .init(named: "banilalatte")!, category: "커피"),
                    MenuData(name: "에스프레소", price: 3500, image: .init(named: "espresso")!, category: "커피")
                ]
                
            case 1:
                // 음료
                data = [
                    MenuData(name: "아이스 제주 말차 라떼", price: 6000, image: .init(named: "malchalatte")!, category: "음료"),
                    MenuData(name: "블루베리 식혜", price: 5500, image: .init(named: "blueberrysikhye")!, category: "음료"),
                    MenuData(name: "오렌지 주스", price: 4500, image: .init(named: "orangejuice")!, category: "음료"),
                    MenuData(name: "말차 스무디", price: 4500, image: .init(named: "smoody")!, category: "음료"),
                    
                ]
                
            case 2:
                // 디저트
                data = [
                    MenuData(name: "플레인 베이글", price: 5000, image: .init(named: "beigle")!, category: "디저트"),
                    MenuData(name: "피칸 파이", price: 4500, image: .init(named: "pikanpie")!, category: "디저트"),
                    MenuData(name: "딸기 케잌", price: 4800, image: .init(named: "strawberrycake")!, category: "디저트"),
                    MenuData(name: "레드벨벳 케잌", price: 5200, image: .init(named: "redvelvetcake")!, category: "디저트"),
                   
                ]
                
            case 3:
                // 상품
                data = [
                    MenuData(name: "마이버디 춘식 키체인", price: 14000, image: .init(named: "chunsik")!, category: "상품"),
                    MenuData(name: "바리스타춘식 투고 텀블러", price: 54000, image: .init(named: "chunsikbaristatogo")!, category: "상품"),
                    MenuData(name: "마이버디 패브릭 코스터 세트", price: 24000, image: .init(named: "febriccoster")!, category: "상품"),
                    MenuData(name: "마이버디 춘식 코나 텀블러", price: 48000, image: .init(named: "chunsikbarista")!, category: "상품"),
                    
                ]
        default:
           data = [MenuData(name: "아이스 아메리카노", price: 4700, image: .init(named: "americano")!, category: "커피")]
        }
        
    }
  
  func setOrderTableView() {
    orderTableView.delegate = self
    orderTableView.dataSource = self
    
    let nib = UINib(nibName: "OrderTableViewCell", bundle: nil)
    orderTableView.register(nib, forCellReuseIdentifier: OrderTableViewCell.cellID)
    
    view.addSubview(orderTableView)
  }
    
    
    func configureCategorySelectionAction() {
        titleView.segview.onSelected = { 
            [weak self] selectedIndex in
            guard
                let self,
                let category = MenuCategory(rawValue: selectedIndex)
            else { return }
            
            switch category{
            case .coffee:
                // 커피
                data = [
                    MenuData(name: "아이스 아메리카노", price: 4700, image: .init(named: "americano")!, category: "커피"),
                    MenuData(name: "아이스 카페라떼", price: 4700, image: .init(named: "cafelatte")!, category: "커피"),
                    MenuData(name: "카페 모카", price: 5000, image: .init(named: "cafemoca")!, category: "커피"),
                    MenuData(name: "바닐라 라떼", price: 5500, image: .init(named: "banilalatte")!, category: "커피"),
                    MenuData(name: "에스프레소", price: 3500, image: .init(named: "espresso")!, category: "커피")
                ]
                
            case .juice:
                // 음료
                data = [
                    MenuData(name: "아이스 제주 말차 라떼", price: 6000, image: .init(named: "malchalatte")!, category: "음료"),
                    MenuData(name: "블루베리 식혜", price: 5500, image: .init(named: "blueberrysikhye")!, category: "음료"),
                    MenuData(name: "오렌지 주스", price: 4500, image: .init(named: "orangejuice")!, category: "음료"),
                    MenuData(name: "말차 스무디", price: 4500, image: .init(named: "smoody")!, category: "음료")
                ]
                
            case .desert:
                // 디저트
                data = [
                    MenuData(name: "플레인 베이글", price: 5000, image: .init(named: "beigle")!, category: "디저트"),
                    MenuData(name: "피칸 파이", price: 4500, image: .init(named: "pikanpie")!, category: "디저트"),
                    MenuData(name: "딸기 케잌", price: 4800, image: .init(named: "strawberrycake")!, category: "디저트"),
                    MenuData(name: "레드벨벳 케잌", price: 5200, image: .init(named: "redvelvetcake")!, category: "디저트")
                ]
                
            case .other:
                // 상품
                data = [
                    MenuData(name: "마이버디 춘식 키체인", price: 14000, image: .init(named: "chunsik")!, category: "상품"),
                    MenuData(name: "바리스타춘식 투고 텀블러", price: 54000, image: .init(named: "chunsikbaristatogo")!, category: "상품"),
                    MenuData(name: "마이버디 패브릭 코스터 세트", price: 24000, image: .init(named: "fabriccoster")!, category: "상품"),
                    MenuData(name: "마이버디 춘식 코나 텀블러", price: 48000, image: .init(named: "chunsikbarista")!, category: "상품")
                ]
       
        }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.orderTableView {
            return OrderTableViewCell.orders.count
        } else {
            return data.count
        }
    }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if tableView == orderTableView {
         orderTableView.deselectRow(at: indexPath, animated: true)
      } else {
         menuTableView.deselectRow(at: indexPath, animated: true)
         setOrderTableView()
         
         let selectedMenu = data[indexPath.row]
         if let existingOrderIndex = OrderTableViewCell.orders.firstIndex(where: { $0.name == selectedMenu.name }) {
            OrderTableViewCell.orders[existingOrderIndex].count += 1
         } else {
            OrderTableViewCell.orders.append(Order(name: selectedMenu.name, price: selectedMenu.price, count: 1))
         }
         paymentView.calSelectedMenu()
         
         orderTableView.reloadData()
      }
   }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if tableView == self.orderTableView {
               let cell = orderTableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.cellID, for: indexPath) as! OrderTableViewCell
               
               cell.setOrderTableViewCell(indexPath: indexPath)
               cell.delegate = self
               
               return cell
               
            } else {
               guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuSelectTableViewCell.identifier, for: indexPath) as? MenuSelectTableViewCell else { return UITableViewCell() }
               
               // 셀 설정
               
               cell.drinkName.text = data[indexPath.row].name
               cell.drinkImage.image = data[indexPath.row].image
               cell.drinkCost.text = String(data[indexPath.row].price)
               
               return cell
            }
         }
      }
   

// OrderTableView 버튼 관련
extension ViewController: OrderTableViewCellDelegate {
  func deleteMenu(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders.remove(at: indexPath.row)
    orderTableView.deleteRows(at: [indexPath], with: .left)
     
     paymentView.calSelectedMenu()
  }
  
  func subtractOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
    
    OrderTableViewCell.orders[indexPath.row].count -= 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    if OrderTableViewCell.orders[indexPath.row].count <= 1 {
      cell.minusButton.isEnabled = false
    }
     
     paymentView.calSelectedMenu()
  }
  
  func addOrderQuantity(for cell: OrderTableViewCell) {
    guard let indexPath = orderTableView.indexPath(for: cell) else { return }
   
    OrderTableViewCell.orders[indexPath.row].count += 1
    cell.orderQuantity.text = String(OrderTableViewCell.orders[indexPath.row].count)
    cell.minusButton.isEnabled = true
     
     paymentView.calSelectedMenu()
  }
  
}
