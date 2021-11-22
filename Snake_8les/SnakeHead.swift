//
//  SnakeHead.swift
//  Snake_8les
//
//  Created by Mariia on 17.11.2021.
//

import UIKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint point: CGPoint) {
        super.init(atPoint: point)
        
        self.physicsBody?.categoryBitMask = CollisionCategories.snakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategories.edgeBody | CollisionCategories.Snake | CollisionCategories.Apple
    }
                
    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
    }
}
