//
//  ViewController.swift
//  Unit 21.7. Circles
//
//  Created by Мария Цуканова on 30.09.2024.
//

import UIKit

class ViewController: UIViewController {
    
    private let circlesCount = 7
    private var circles: [CustomView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateCircles()
    }

    private func generateCircles() {
        for i in 0...circlesCount - 1 {
            let center = CGPoint(x: 30 + i * 30, y: 80 + 170 * (i % 4))
            let radius = CGFloat(30 + i * 4)
            let circle = CustomView(center: center, radius:radius)
            circle.delegate = self
            view.addSubview(circle)
            circles.append(circle)
        }
    }
}

extension ViewController: CircleDelegate {
    func moved(_ circle: CustomView) {
        intersectingCircles(with: circle).forEach {
            anotherCircle in circle.eat(anotherCircle)
        }
    }
    
    private func intersectingCircles(with circle: CustomView) -> [CustomView] {
        var answer = [CustomView]()
        for anotherCircle in circles.filter({$0 !== circle}) {
            if circle.frame.intersects(anotherCircle.frame) {
                answer.append(anotherCircle)
            }
            
        }
        return answer
    }
    
}


