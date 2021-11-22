//
//  GameViewController.swift
//  Snake_8les
//
//  Created by Mariia on 16.11.2021.
//

import UIKit
import SpriteKit
import GameplayKit
//GameViewController is responsible for one screen of the application that we see (one screen – one GameViewController
class GameViewController: UIViewController /* класс родитель*/ {
//1. viewDidLoad работает когда все элементы уже загружены и экран готов отобржать  игру
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //потребуется сцена с размерами, которые будем брать из нашего экрана
        let scene = GameScene(size: view.bounds.size) //view - это экран, bounds - размеры экрана
        
        let skView = view as! SKView //view определенного класса - SKView,  спец класс, где можно разместить сцену с определенными обьектами
        //включим опеределенные параметры, могут и не понадобится, но покажем что они есть
        skView.showsFPS = true //показ FPS часть (the number of frames per second)
        skView.showsNodeCount = true //показ количества обьектов (Nodes)
        skView.ignoresSiblingOrder = true // показатель, отвечающий за рендеринг(отрисовку) обьектов. Когда он включен - отрисовка обьектов на экране будет в произвольном порядке. Когда выключен - отрисовка будет сверху-вниз
        //сцену растянем по всему экрану
        scene.scaleMode = .resizeFill
        //разместим на нашу вьюшку сцену только что созданную
        skView.presentScene(scene)
        
    
    }
}

  
