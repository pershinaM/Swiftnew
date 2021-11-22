//
//  GameScene.swift
//  Snake_8les
//
//  Created by Mariia on 16.11.2021.
//

import SpriteKit
import GameplayKit
//в swift принято называть файл также как назван класс, который в нем хранится

//создадим структуру битовые  масок, где пропишем категории, которые нужны будут для описания столкновений и что они дают
struct CollisionCategories {
    //пропишем категории: Snake со смещение еденицы
    static let Snake: UInt32 = 0x1 << 0 // 0001
    // категория snakeHead
    static let snakeHead: UInt32 = 0x1 << 1 // 0010
    static let Apple: UInt32 = 0x1 << 2 // 0100
    //категория гринца экрана
    static let edgeBody:UInt32 = 0x1 << 3 // 1000
    
}



class GameScene: SKScene {
    
    var snake: Snake?
    var gameFrameRect: CGRect = .zero
    var gameFrameView: SKShapeNode!
    var startButton: SKLabelNode!
    var stopButton: SKLabelNode!
    
    //2.
    //didMove один из самых главных методов сцены, вызывается в момент запуска сцены. все обьекты, которые нужны при начальном использовании нашей сцены должны быть созданны в данном методе
    override func didMove(to view: SKView) {
        //добав         им цвет нашей сцене
        backgroundColor = SKColor.black
        //скажем что у нас есть вектор и гравитация. Здесь говорим, что нижний левый угол будет началом координат, от него мы будем считать
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        //добавим физику, здесь говорим, что физические свойства должны действовать на всем экране - add Frame
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        //отключим поворот экрана
        self.physicsBody?.allowsRotation = false
        // отобразим на нашем экране параметры( FPS, Node exp)
        view.showsPhysics = true
        
        let margin: CGFloat = 20
        let gameFrame = frame.inset (by: view.safeAreaInsets)
        gameFrameRect = CGRect (x: margin, y: margin + view.safeAreaInsets.top + 55,
                                width: gameFrame.width - margin * 2, height: gameFrame.height - margin * 2 - 55)
                drawGameFrame ()
        
        guard let scene = view.scene else {
                    return
                }
        
        
        //создадим две кнопки, которые будут напрвлять змейку вправо и влево
        
        let counterClockWiseButton = SKShapeNode()  //всо обьекты.которые размещаются на сцене -все обьекты класса SKShapeNode
        //перередадим кнопке параметры
        //параметр path - форма кнопки
        counterClockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        //определим позицию кнопки
        counterClockWiseButton.position = CGPoint(x: view.scene!.frame.minX + 30, y: view.scene!.frame.minY + 30)
        //   цвет кнопки
        counterClockWiseButton.fillColor = .cyan
        //цвет рамки, которая будет видна при нажатии на кнопку
        counterClockWiseButton.strokeColor = .cyan
        //отпределим размер рамки
        counterClockWiseButton.lineWidth = 10
        // определим имя кнопки, чтобы можно было далее к ней обратиться. Обычно совпадают имена
        counterClockWiseButton.name = "counterClockWiseButton"
         //теперь разместим нашу кнопку на сцене
        self.addChild(counterClockWiseButton)
        
        //создадим вторую кнопку
        let clockWiseButton = SKShapeNode()
        clockWiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        clockWiseButton.position = CGPoint(x: view.scene!.frame.maxX - 80, y: view.scene!.frame.minY + 30 )
        clockWiseButton.fillColor = .cyan
        clockWiseButton.strokeColor = .cyan
        clockWiseButton.lineWidth = 10
        clockWiseButton.name = "clockWiseButton"
        self.addChild(clockWiseButton)
        
        createApple()
        
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        //опишем что сцена будет сама делегатом
        self.physicsWorld.contactDelegate = self
        
        
        //пропишем столкновения с границей экрана
        self.physicsBody?.categoryBitMask = CollisionCategories.edgeBody
        self.physicsBody?.collisionBitMask = CollisionCategories.Snake | CollisionCategories.snakeHead
        
        startButton = SKLabelNode (text: "S T A R T")
        startButton.position = CGPoint (x: view.scene!.frame.midX, y: 55)
                startButton.fontSize = 40
                startButton.fontColor = .green
                startButton.name = .startButtonName
                addChild (startButton)
         
                stopButton = SKLabelNode (text: "S T O P")
        stopButton.position = CGPoint (x: view.scene!.frame.midX, y: 55)
                stopButton.fontSize = 40
                stopButton.fontColor = .red
                stopButton.name = .stopButtonName
                stopButton.isHidden = true
                addChild (stopButton)
        
        func drawGameFrame () {
               gameFrameView = SKShapeNode (rect: gameFrameRect)
               gameFrameView.fillColor = .lightGray
               gameFrameView.lineWidth = 2
               gameFrameView.strokeColor = .green
               addChild (gameFrameView)
           }
        
    }
    func findTouchedNode (with touches: Set<UITouch>) -> SKNode? {
           return touches.map { [unowned self] touch in touch.location (in: self)}
               .map {atPoint ($0)}
               .first
       }
    
    // метод обработки нажатия на экран. Состоит из сета( множества)
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*guard let touchedNode = findTouchedNode (with: touches) else {
                    return
                }
        if let shapeNode = touchedNode as? SKShapeNode,
                   touchedNode.name == .counterClockwiseButtonName || touchedNode.name == .clockwiseButtonName {
                   shapeNode.fillColor = .green
                   if touchedNode.name == .counterClockwiseButtonName {
                       snake? .moveCounterClockWise ()
                   } else if touchedNode.name == .clockwiseButtonName {
                       snake? .moveClockWise ()
                   }
               } else if touchedNode.name == .startButtonName {
                   start ()
               } else if touchedNode.name == .stopButtonName {
                   stop ()
               }*/
      //напишем цикл где touches будет множество SET, содержаший уникальные нажатия кнопки
        for touch in touches {
            //определем параметр который отвечает за определенные координаты где произошло нажатие
            let touchLocation = touch.location(in: self)
            // проверим: если обьект на который произошло нажатие был класса SKShapeNode и также он должен иметь два имени. И одно из этих имен сплыло, то что то делаем, иначе return
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
             return
            }
            // eсли это прошло проверку, то меняем touchNode цвет
                touchNode.fillColor = .systemIndigo
            if touchNode.name == "counterClockWiseButton" {
                snake!.moveCounterClockWise()
            } else if touchNode.name == "clockWiseButton" {
                snake!.moveClockWise()
            } else if touchNode.name == .startButtonName {
                start ()
            } else if touchNode.name == .stopButtonName {
                stop ()
            }
            
         }
        
    }
    // отрабатывает когда палец от экрана убрали, те прикрощения нажатия на экран
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* guard let touchedNode = findTouchedNode (with: touches) else {
                    return
                }
        
        if let shapeNode = touchedNode as? SKShapeNode,
                   touchedNode.name == .counterClockwiseButtonName || touchedNode.name == .clockwiseButtonName {
                   shapeNode.fillColor = .gray
               }*/
        
       
       //когда отжимаем кнопку все тоже самое,только должны вернуть цвет первоначальный кнопки
        for touch in touches {
            let touchLocation = touch.location(in: self)
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, touchNode.name == "counterClockWiseButton" || touchNode.name == "clockWiseButton" else {
            return
            }
                touchNode.fillColor = .cyan
        }
    }
    // срабатывает когда проихсодит резкий случаный обрыв касания на экран от пользователя- напримр поступающий звонок, экран звонка перекрывает экран игры -и игра например должна поставиться на паузу
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchedNode = findTouchedNode (with: touches) else {
                    return
                }
         
                if let shapeNode = touchedNode as? SKShapeNode,
                    touchedNode.name == .counterClockwiseButtonName || touchedNode.name == .clockwiseButtonName {
                    shapeNode.fillColor = .gray
                }
    }
    
    //служит для обновления наших кадров, например передвигается змейка и тп
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        snake?.move()
    }
    
    func createApple() {
        // создадим рандомный х, исп-ем метод arc4random_uniform, к-рый нужен рандомного создания числа, даем ему определ.диапазон, в к-ром создается число - это наш экран
        let randomX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX - 5)))
        let randomY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY - 5)))
        //создадим яблоко, к-рое будет где то в рандомном месте
        let apple = Apple(position: CGPoint(x: randomX, y: randomY))
        //размещаем яблоко на сцене
        self.addChild(apple)
    }
    
    private func start () {
            guard let scene = scene else {return}
     
        snake = Snake (atPoint: CGPoint (x: (view?.scene!.frame.midX)!, y: (view?.scene!.frame.midY)!))
         self.addChild (snake!)
     
            createApple ()
     
            startButton.isHidden = true
            stopButton.isHidden = false
        }
    private func stop() {
        snake = nil
        self.removeAllChildren()
        
        startButton.isHidden = false
        stopButton.isHidden = true
        
    }
}

//напишем протокол
extension GameScene: SKPhysicsContactDelegate {
//метод когда происходит столкновение -он срабатывает
    func didBegin(_ contact: SKPhysicsContact) {
        //cсоздадим бодис котороый будет содежрать логическую сумму двух столкнувшихся элементов. Мы не знаем к какому из этих боди а и б относится змея и яблоко. Поэтому надо вычислить-яблоко удалить, а змею увеличить
        var bodies = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        bodies ^= CollisionCategories.snakeHead
        //надл понять какой обьект где. вычтем из бодис голову змею. только она двигается и может столкнуться с другими обьетами
        //let collisionObject = bodies - CollisionCategories.snakeHead
        //обработаем с пом свитча, определим какой из обьектов А или Б ялвяется яблоком или змеей
        switch bodies {
        case CollisionCategories.Apple:
            //если переменная которая хранится в боди А не является обьектом класса Яблоко, то переменой  apple присваиваем бодиБ
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
        case CollisionCategories.edgeBody:
            stop()
           break
            
        default:
            break
        }
    }
}
  
    
    private extension String {
        static let counterClockwiseButtonName = "counterClockwiseButton"
        static let clockwiseButtonName = "clockwiseButton"
     
        static let startButtonName = "startButton"
        static let stopButtonName = "stopButton"
    }

