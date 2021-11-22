//
//  SnakeBodyPart.swift
//  Snake_8les
//
//  Created by Mariia on 16.11.2021.
//

import UIKit
import SpriteKit

//  создадим класс и пропишем инициализатор
class SnakeBodyPart: SKShapeNode {
    
    let diametr: CGFloat = 10
    
    init (atPoint point: CGPoint) {
        super.init()
        
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: diametr, height: diametr)).cgPath
        fillColor = .green
        strokeColor = .green
        lineWidth = 10
        // создадим физич тело
        self.physicsBody = SKPhysicsBody(circleOfRadius: (diametr - 4), center: CGPoint(x: 5, y: 5))
        //отметим параметр как динамичнй, который будет перемещаться
        self.physicsBody?.isDynamic = true
        //определим к какой группе относитсся данный обьект
        self.physicsBody?.categoryBitMask = CollisionCategories.Snake
        //скажем с кем этот обьект может столкнуться
        self.physicsBody?.contactTestBitMask = CollisionCategories.edgeBody | CollisionCategories.Apple
        
        self.position = point
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
