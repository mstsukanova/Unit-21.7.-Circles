//
//  CustomView.swift
//  Unit 21.7. Circles
//
//  Created by Мария Цуканова on 30.09.2024.
//

import UIKit

protocol CircleDelegate: AnyObject {
    func moved(_ circle: CustomView)
}

@IBDesignable class CustomView: UIView {
    private let red: CGFloat = 50 / 255.0
    private let green:CGFloat = 100 / 255.0
    private let blue: CGFloat = 200 / 255.0
    
    private var lastLocation: CGPoint = .zero
    
    weak var delegate: CircleDelegate?
    
    init(center: CGPoint, radius: CGFloat) {
    
        
        let width = radius * 2
        let size = CGSize(width: width, height: width)
        
        
        super.init(frame: CGRect(origin: center, size: size))
        self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(detectPan))
        addGestureRecognizer(panRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented ")
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        layer.cornerRadius = frame.height / 2
    }
    
    func eat (_ anotherCircle: CustomView) {
        if self.frame.size.width < anotherCircle.frame.size.width {
            anotherCircle.eat(self)
            return
        }
            
        self.backgroundColor = UIColor(
            red: self.red,
            green: 50 / 255.0,
            blue: 100 / 255.0,
            alpha: 1.0)
        let scaleFactor: CGFloat = 1.2
        self.frame.size = CGSize(width: self.frame.width * scaleFactor, height: self.frame.height * scaleFactor)
        self.center.x -= self.frame.width * (scaleFactor - 1) / 2
        self.center.y -= self.frame.width * (scaleFactor - 1) / 2
        self.layoutIfNeeded()
        anotherCircle.alpha = 0
        anotherCircle.removeFromSuperview()
        }
               
        

    
    @objc private func detectPan(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: superview)
        center = CGPoint(
            x: lastLocation.x + translation.x,
            y: lastLocation.y + translation.y)
        if recognizer.state == .ended {
            delegate?.moved(self)
        }
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        superview?.bringSubviewToFront(self)
        lastLocation = center
    }
  
}
    
