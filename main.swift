//
//  main.swift
//  5L-PerhinaMariia
//
//  Created by Mariia on 08.11.2021.
//

import Foundation

/* 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести сами объекты в консоль. */




enum carWindowState {
    case open, close
}

enum carEngineState {
    case on, off
}

enum spoilerState {
    case raise, down
}


protocol Car {
    var model: String {get}
    var color: String {get}
    var km: Double {get}
    var windowState: carWindowState {get set}
    var engineState: carEngineState {get set}
}

extension Car {
    mutating func changeWindowState (windowState: carWindowState) {
        return  self.windowState = windowState
    }
    
    mutating func changeEngineStatus (engineStatus: carEngineState) {
        return self.engineState = engineStatus
    }
}

protocol ConsolePrintable: CustomStringConvertible {
    func printDescription ()
}
extension ConsolePrintable{
    func printDecription () {
        print(description)
    }
}

class SportCar: Car, ConsolePrintable{
  
    var clearence: Double
    var spoiler: spoilerState
    var model: String
    var color: String
    var km: Double
    var windowState: carWindowState
    var engineState: carEngineState
    
    var description: String {
        return String(describing: "Model: \(model), color: \(color), km: \(km), spoiler: \(spoilerState.self), clearence: \(clearence), windowState: \(carWindowState.self), engineStatus: \(carEngineState.self)")
    }

    func printDescription()  {
        return printDescription()
    }
    
    init (model: String, color: String, km: Double, spoiler: spoilerState, clearence: Double, windowState: carWindowState, engineStatus: carEngineState) {
        self.model = model
        self.color = color
        self.km = km
        self.spoiler = spoiler
        self.clearence = clearence
        self.windowState = windowState
        self.engineState = engineStatus
    }

    
}

var sportCar1 = SportCar (model: "Tesla", color: "red", km: 0.0, spoiler: .down, clearence: 50, windowState: .close, engineStatus: .off)
print (sportCar1.windowState)
sportCar1.changeWindowState(windowState: .open)
print (sportCar1.windowState)
sportCar1.printDecription()

enum trunkState {
    case load, unload
}

class TruckCar: Car, ConsolePrintable {
    var model: String
    var color: String
    var km: Double
    var windowState: carWindowState
    var engineState: carEngineState
    
    var liftingcapacity: Double
    var trunkTruckCar: trunkState
    
    var description: String {
        return String (describing: "\(model) имеет грузоподьемность \(liftingcapacity) тонн")
    }
    
    func printDescription() {
        return printDecription()
    }
    
    init (model: String, color: String, km: Double, liftingCapacity: Double, trunkTruckCar: trunkState, windowState: carWindowState, engineStatus: carEngineState) {
        self.model = model
        self.color = color
        self.km = km
        self.liftingcapacity = liftingCapacity
        self.trunkTruckCar = trunkTruckCar
        self.windowState = windowState
        self.engineState = engineStatus
    }
    
}

var MAN = TruckCar (model: "MAN", color: "yellow", km: 108379.0, liftingCapacity: 35, trunkTruckCar: .load, windowState: .close, engineStatus: .off)
MAN.printDescription()
print(MAN.engineState)

MAN.changeEngineStatus(engineStatus: .on)
print(MAN.engineState)
