//
//  SegmentView.swift
//  OrderSo10Jo
//
//  Created by 송정훈 on 4/3/24.
//

import UIKit

protocol SegmentViewDelegate: AnyObject {
  func segmentView(_ segmentView: SegmentView, didSelectSegmentAt index: Int)
}

class SegmentView: UIView {
    override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init?(coder:) is not supported")
        }
  
    static weak var delegate: SegmentViewDelegate?
    
    //MARK: segmentControl
    static var segmentControl: UISegmentedControl = {
            let segment = UISegmentedControl()
            
            segment.selectedSegmentTintColor = .clear
            
            // 배경 색 제거
            segment.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
            // Segment 구분 라인 제거
            segment.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            
            segment.insertSegment(withTitle: "커피", at: 0, animated: true)
            segment.insertSegment(withTitle: "음료", at: 1, animated: true)
            segment.insertSegment(withTitle: "디저트", at: 2, animated: true)
            segment.insertSegment(withTitle: "상품", at: 3, animated: true)
            segment.selectedSegmentIndex = 0
            
            // 선택 되어 있지 않을때 폰트 및 폰트컬러
            segment.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ], for: .normal)
            
            // 선택 되었을때 폰트 및 폰트컬러
            segment.setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)
            ], for: .selected)
            
            segment.addTarget(self, action: #selector(changeUnderLinePosition), for: .valueChanged)
            
            segment.translatesAutoresizingMaskIntoConstraints = false
            return segment
        }()
    
    private lazy var underLineView: UIView = {
            let view = UIView()
            view.backgroundColor = .black
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
  
    private lazy var underLineDefaultView: UIView = {
            let view = UIView()
            view.backgroundColor = .systemGray5
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var leadingDistance: NSLayoutConstraint = {
      return underLineView.leadingAnchor.constraint(equalTo: SegmentView.segmentControl.leadingAnchor)
        }()
    
    func configure() {
      addSubview(SegmentView.segmentControl)
           addSubview(underLineDefaultView)
           addSubview(underLineView)
           NSLayoutConstraint.activate([
            SegmentView.segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            SegmentView.segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            SegmentView.segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            SegmentView.segmentControl.heightAnchor.constraint(equalToConstant: 35),
               underLineDefaultView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               underLineDefaultView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               underLineDefaultView.heightAnchor.constraint(equalToConstant: 1),
            underLineDefaultView.bottomAnchor.constraint(equalTo: SegmentView.segmentControl.bottomAnchor),
            underLineView.bottomAnchor.constraint(equalTo: SegmentView.segmentControl.bottomAnchor),
               underLineView.heightAnchor.constraint(equalToConstant: 1),
               leadingDistance,
            underLineView.widthAnchor.constraint(equalTo: SegmentView.segmentControl.widthAnchor, multiplier: 1 / CGFloat(SegmentView.segmentControl.numberOfSegments))
           ])
       }
    
    @objc public func changeUnderLinePosition(_ sender: UISegmentedControl) {
      let segmentIndex = CGFloat(SegmentView.segmentControl.selectedSegmentIndex)
      let segmentWidth = SegmentView.segmentControl.frame.width / CGFloat(SegmentView.segmentControl.numberOfSegments)
            let leadingDistance = segmentWidth * segmentIndex
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.leadingDistance.constant = leadingDistance
                self?.layoutIfNeeded()
            })

      if let delegate = SegmentView.delegate {
              delegate.segmentView(self, didSelectSegmentAt: sender.selectedSegmentIndex)
      }
    }
    
}
