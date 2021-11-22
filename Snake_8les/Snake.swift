//
//  Snake.swift
//  Snake_8les
//
//  Created by Mariia on 17.11.2021.
//

import UIKit
import SpriteKit

class Snake: SKShapeNode {
    var body = [SnakeBodyPart]()
    var moveSpeed: CGFloat = 125
    var angle:CGFloat = 0.0
    
    
    init(atPoint point: CGPoint) {
        super.init()
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBodyPart() {
        //создадим новый элемент, котороый будет новым сегментом змейки
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move(){
        //проверяем пустой ли массив у body
        guard !body.isEmpty else {return}
        
        let head = body[0]
        moveHead(head)
        
        for index in (0 ..< body.count) where index>0 {
            let previousBodyPart = body[index-1]
            let currentBodyPart = body[index]
            MoveBodyPart(previousBodyPart, c: currentBodyPart)
        }
        
    }
    //напишем функцию перемещения змейки из пункта А в пункт Б с новыми координатами
    func moveHead(_ head: SnakeBodyPart){
        var dx = moveSpeed * sin(angle)
        var dy = moveSpeed * cos(angle)
        //пропишем след позицию с прибавление к голове dx dy
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        //переменная передвижения с методом move
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        //запустим змейку с пом метода run
        head.run(moveAction)
    }
    
    func MoveBodyPart( _ p: SnakeBodyPart, c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        
        c.run(moveAction)
    }
    //напишем 2 метода которые дадут управлять змейкой
    func moveClockWise() {
        angle += CGFloat(Double.pi/2)
    }
    func moveCounterClockWise() {
        angle -= CGFloat(Double.pi/2)
    }
}
