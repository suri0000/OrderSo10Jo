//
//  SegmentView.swift
//  OrderSo10Jo
//
//  Created by 송정훈 on 4/3/24.
//

import UIKit

class SegmentView: UIView {
    override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init?(coder:) is not supported")
        }
    
    //MARK: segmentControl
    private lazy var segmentControl: UISegmentedControl = {
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
                NSAttributedString.Key.foregroundColor: UIColor.gray,
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
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
    
    private lazy var leadingDistance: NSLayoutConstraint = {
            return underLineView.leadingAnchor.constraint(equalTo: segmentControl.leadingAnchor)
        }()
    
    func configure() {
           addSubview(segmentControl)
           addSubview(underLineDefaultView)
           addSubview(underLineView)
           NSLayoutConstraint.activate([
               segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               segmentControl.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
               segmentControl.heightAnchor.constraint(equalToConstant: 35),
               underLineDefaultView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
               underLineDefaultView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
               underLineDefaultView.heightAnchor.constraint(equalToConstant: 1),
               underLineDefaultView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
               underLineView.bottomAnchor.constraint(equalTo: segmentControl.bottomAnchor),
               underLineView.heightAnchor.constraint(equalToConstant: 2),
               leadingDistance,
               underLineView.widthAnchor.constraint(equalTo: segmentControl.widthAnchor, multiplier: 1 / CGFloat(segmentControl.numberOfSegments))
           ])
       }
    
    @objc private func changeUnderLinePosition() {
            let segmentIndex = CGFloat(segmentControl.selectedSegmentIndex)
            let segmentWidth = segmentControl.frame.width / CGFloat(segmentControl.numberOfSegments)
            let leadingDistance = segmentWidth * segmentIndex
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.leadingDistance.constant = leadingDistance
                self?.layoutIfNeeded()
            })
        }
    
}
