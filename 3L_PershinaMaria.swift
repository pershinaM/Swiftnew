//
//  3L_PershinaMariiaHomeWork.swift
//  lesson_3_Перечисления_структура
//
//  Created by Mariia on 28.10.2021.
//

import Foundation
import Cocoa

/* Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль. */
enum enginState {
    case on, off
}
enum windowState {
    case open, close
}
enum trunkState {
    case load, unload
}

struct sportCar {
    let model: String
    var color: String
    let yearOfProduction: Int
    var trunkLength: Double
    var trunkWidth: Double
    var trunkDepth: Double
    var trunkVolume: Double {
        get {
            return trunkWidth * trunkDepth * trunkLength
        }
    }
    var bodyValue: Double
    var engineState: enginState {
        willSet {
            if newValue == .on {
                print("Двигатель сейчас заведется у \(model)")
            } else {
                print("Двигатель сейчас заглохнет у \(model)")
            }
        }
    }
    
    var window: windowState {
        willSet {
            if newValue == .open {
                print("Окно сейчас откроется  у \(model)")
            } else {
                print("Окно сейчас закроется у \(model)")
            }
        }
    }
    
    var trunkState: trunkState {
        willSet {
            if newValue == .load {
                print("Багажник сейчас загрузится у \(model)")
            } else {
                print("Багажник сейчас разгрузят у \(model)")
            }
        }
    }
    
    mutating func closeWindow () {
        self.window = .close
      //  print ("Окно \(carBMW_3.model) закрыто")
    }
    mutating func openWindow () {
        self.window = .open
        //print ("Окно \(carBMW_3.model) открыто")
    }
    
    mutating func changeColor (color: String){
        switch color {
        case "white":
            self.color = "white"
        case  "yellow":
            self.color = "yellow"
        case "pink":
            self.color = "pink"
        default:
            print( "Input error!")
    
        }
    }
    
    /*init () {
        trunkDepth = 0.5
        trunkWidth = 1.5
        trunkLength = 1
    }
    
    init (trunkDepth: Double, trunkWidth: Double, trunkLength: Double) {
        self.trunkDepth = trunkDepth
        self.trunkLength = trunkLength
        self.trunkWidth = trunkWidth
    }*/
}

var carBMW_3 = sportCar(model: "BMW_3", color: "white", yearOfProduction: 2020, trunkLength: 1.6, trunkWidth: 1.2, trunkDepth: 0.3, bodyValue: 6, engineState: .off, window: .close, trunkState: .unload)
var carScoda = sportCar(model: "Octavia", color: "yellow", yearOfProduction: 2019, trunkLength: 1, trunkWidth: 1, trunkDepth: 0.2, bodyValue: 8, engineState: .on, window: .close, trunkState: .load)


carBMW_3.window = .open
carBMW_3.window = .close
carBMW_3.trunkState = .unload
carBMW_3.engineState = .on

carBMW_3.trunkLength = 1.5
carBMW_3.trunkWidth = 1.5
carBMW_3.trunkDepth = 0.4
carBMW_3.trunkVolume
print ("\(carBMW_3.trunkVolume) обЪем багажника у \(carBMW_3.model)")
//print(carBMW_3.yearOfProduction)

carBMW_3.closeWindow()

carScoda.changeColor(color: "pink")


carScoda.openWindow()
carScoda.trunkState = .load

print (" Характеристики \(carScoda.model) ,цвет авто \(carScoda.color), год выпуска \(carScoda.yearOfProduction) ,  объем кузова \(carScoda.bodyValue), в данное время двигатель в режиме  \(carScoda.engineState), объем багажника \(carScoda.trunkVolume), сейчас окна \(carScoda.window)")


// вторая структура для Грузовика

struct truckCar {
    let model: String
    var color: String
    let yearOfProduction: Int
    
    var trunkVolume: Double {
        didSet {
            if (trunkState == .unload) && (trunkVolume > 0) && (trunkVolume != 0) && (oldValue > trunkVolume) {
                let space = oldValue - trunkVolume
                print ("У \(model) кузов свободен на  \(space)")
            } else {
                print ("Ошибка ввода или кузов у \(model)  полон ")
            }
        }
    }
    
    var engineState: enginState {
        willSet {
            if newValue == .on {
                print("Двигатель сейчас заведется у \(model)")
            } else {
                print("Двигатель сейчас заглохнет у \(model)")
            }
        }
    }
    
    var window: windowState {
        willSet {
            if newValue == .open {
                print("Окно сейчас откроется  у \(model)")
            } else {
                print("Окно сейчас закроется у \(model)")
            }
        }
    }
    
    var trunkState: trunkState {
        willSet {
            if newValue == .load {
                print("Кузов сейчас загрузится у \(model)")
            } else {
                print("Кузов сейчас разгрузят у \(model)")
            }
        }
    }
    
    mutating func closeWindow () {
        self.window = .close
      //  print ("Окно \(carBMW_3.model) закрыто")
    }
    mutating func openWindow () {
        self.window = .open
        //print ("Окно \(carBMW_3.model) открыто")
    }
    
    mutating func changeColor (color: String){
        switch color {
        case "white":
            self.color = "white"
        case  "yellow":
            self.color = "yellow"
        case "pink":
            self.color = "pink"
        default:
            print( "Input error!")
    
        }
    }
}

print ("-----------------------")

var truckMAN = truckCar(model: "MAN", color: "white", yearOfProduction: 2010, trunkVolume: 10000, engineState: .on, window: .open, trunkState: .load)
var truckKamaz = truckCar(model: "Kamaz", color: "pink", yearOfProduction: 2021, trunkVolume: 12000, engineState: .off, window: .close, trunkState: .unload)

truckKamaz.trunkVolume = 13000
truckKamaz.trunkVolume = 9000

truckMAN.closeWindow()
truckKamaz.changeColor(color: "yellow")

print ("Характеристики \(truckKamaz.model) ,цвет авто \(truckKamaz.color), год выпуска \(truckKamaz.yearOfProduction) , в данное время двигатель в режиме  \(truckKamaz.engineState), объем кузова \(truckKamaz.trunkVolume), сейчас окна \(truckKamaz.window)")
