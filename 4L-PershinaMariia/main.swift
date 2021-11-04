//
//  main.swift
//  4L-PershinaMariia
//
//  Created by Mariia on 04.11.2021.
//

import Foundation

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
enum carDoorState {
    case open, close
}

enum carWindowState {
    case open, close
}
enum spoilerState {
    case raise, down
}

enum trunkState {
    case load, unload
}

class Car {
    let model: String
    let color: String
    var km: Double
    var doorState: carDoorState
    var accelerationto100kmhIn1sec: Double
    var windowState: carWindowState
    var trunkState: trunkState {
        willSet {
            if newValue == .load {
                print("Багажник сейчас загрузится у \(model)")
            } else {
                print("Багажник сейчас разгрузят у \(model)")
            }
        }
    }
  
    // добавим свойство подсчитывающее количество машин, побивших рекорд превышения заявленной скорости при разгоне до 100 км/ч за 1 сек
    static var recordAcceleration = 0
    
    
    init (model: String, color: String, km: Double, doorState: carDoorState, accelerationto100kmhIn1sec: Double, windowState: carWindowState, trunkState: trunkState ) {
        self.model = model
        self.color = color
        self.km = km
        self.doorState = doorState
        self.accelerationto100kmhIn1sec = accelerationto100kmhIn1sec
        self.windowState = windowState
        self.trunkState = trunkState
        //в конструкторе увеличим переменную,если условие верно
        if self.accelerationto100kmhIn1sec <= 10 {
            Car.recordAcceleration += 1
        }
    }
    
    static func printRecordInfo(){
        print("Побили рекорд при разгоне до 100 км/ч за 1 сек \(self.recordAcceleration) машины " )
    }
    
    func closeWindow () {
        self.windowState = .close
     
    }
    func openWindow () {
        self.windowState = .open
    }
    
    
    
}
let car1 = Car (model: "Nissan", color: "yellow", km: 0.0, doorState: .close, accelerationto100kmhIn1sec: 10, windowState: .close, trunkState: .load )
let car2 = Car (model: "Lada", color: "pink", km: 10000.0, doorState: .close, accelerationto100kmhIn1sec: 16, windowState: .close, trunkState: .unload)
let car3 = Car (model: "Ford", color: "green", km: 100.0, doorState: .close, accelerationto100kmhIn1sec: 9, windowState: .close, trunkState: .unload)

print (Car.recordAcceleration)
Car.printRecordInfo()

//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.

class sportCar: Car {
    var clearence: Double // новое свойство
    var spoiler: spoilerState
    //перечисляем все свойства
    init (model: String, color: String, km: Double, doorState: carDoorState, accelerationto100kmhIn1sec: Double, windowState: carWindowState, trunkState: trunkState, clearence: Double, spoiler: spoilerState){
        self.clearence = clearence  //инициализируем новое свойство
        self.spoiler = spoiler
        
    // используем конструктор из родителя Сar, чтобы завершить инициализацию
        super.init(model: model, color: color, km: km, doorState: doorState, accelerationto100kmhIn1sec: accelerationto100kmhIn1sec, windowState: windowState, trunkState: trunkState)
    }
    
    func raiseSpoiler (){
        spoiler = .raise
        print ("Spoler \(spoiler) ")
    }
    func downSpoiler (){
        spoiler = .down
        print ("Spoler \(spoiler) ")
    }
    
}
var sportCar1 = sportCar(model: "Ferarri", color: "Red", km: 0.0, doorState: .open, accelerationto100kmhIn1sec: 4, windowState: .close, trunkState: .unload, clearence: 3, spoiler: .raise)
print(sportCar1.clearence)
print(sportCar1.spoiler)
sportCar1.downSpoiler()


class truckCar: Car {
    var liftingcapacity: Double
    var trunkTruckCar: trunkState

    
    init (model: String, color: String, km: Double, doorState: carDoorState, accelerationto100kmhIn1sec: Double, windowState: carWindowState, liftingcapacity: Double, trunkTruckState: trunkState){
        self.liftingcapacity = liftingcapacity
        self.trunkTruckCar = trunkTruckState
        
        super.init(model: model, color: color, km: km, doorState: doorState, accelerationto100kmhIn1sec: accelerationto100kmhIn1sec, windowState: windowState, trunkState: trunkTruckState)
    }
    
    override func closeWindow () {
        self.windowState = .close
        print( "Window is closed ")
     
    }
    
    
    
}

var truck1 = truckCar(model: "Kamaz", color: "red", km: 0.0, doorState: .close, accelerationto100kmhIn1sec: 50, windowState: .close, liftingcapacity: 10, trunkTruckState: .load)
print (truck1.liftingcapacity)
truck1.trunkState = .load
truck1.closeWindow()


//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
