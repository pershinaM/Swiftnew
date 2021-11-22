//
//  Apple.swift
//  Snake_8les
//
//  Created by Mariia on 16.11.2021.
//

import UIKit
import SpriteKit

class Apple: SKShapeNode {
    
    //создадим инициализатор и пусто супре для родителя
    init( position: CGPoint) {
        super.init()
        // создадим яблоко как обьект, как оно будет выглядить
        path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 10, height: 10)).cgPath
        
        fillColor = .red
        strokeColor = .red
        lineWidth = 10
        //создадим физическое тело яблоку
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10.0, center: CGPoint(x: 5, y: 5))
        self.physicsBody?.categoryBitMask = CollisionCategories.Apple
        
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//мы создали класс, теперь нужно создать сам обьект в GameCenter
