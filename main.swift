//
//  main.swift
//  Lesson_5_OOP_practice
//
//  Created by Mariia on 06.11.2021.
//

import Foundation

//  ПРОТОКОЛЫ - объявляют стандарт Любой ваш класс, структура или перечисление может принять этот стандарт и реализовать все, что описано в протоколе. Кроме того, вы можете использовать протокол для указания типа переменных или массивов. Это позволяет присваивать им значения любых типов, лишь бы эти типы имплементировали протокол.
 
/*protocol SomeProtocol {
    //определяем свойства
}

struct SomeStructure: FirstProtocol, SomeProtocol, ... {
    
}

class SomeClass: SuperClass, FirstProtocol {
    
}


protocol SomeProtocol {
    //определяем свойства, только var ,
    var mustBeSettable: Int {get set} //прочитать  и изменить
    var doesnotBeSettable: Int {get} // get минимал требование
}  */
 
protocol FullNamed {
    var fullname: String {get}  // рассмотрим протокол с  get который всегда что то возвращает
}

struct Person {
    var fullname: String //реализуем протокол
}

let john = Person (fullname: "John")

class StarShip: FullNamed {
    var prefix: String?
    var name: String
    
    var fullname: String {
        get {
        return (prefix != nil ?  prefix! + " " : " ") + name
        }
    }
    
    init (name: String, prefix: String? = nil) {
        self.name  = name
        self.prefix = prefix
    }
}

var ncc1701  = StarShip (name: "Enterprise", prefix: "USS")
print (ncc1701.fullname)

// создадим второй протокл с get set

protocol NamedKnight {
    var nameKnight: String {get set}
}

struct knight: NamedKnight {
    var name: String
    var nameKnight: String {
        get {
            return name
        }
        set (newV) {
            name = newV + " knight of Westeros"
        }
    }
}

var knightJ = knight (name: "Walter")
print (knightJ.nameKnight) // выводит то что было в get

// поменям имя и тогда напишите то что было в set
knightJ.nameKnight = "John Snow"
print (knightJ.nameKnight)


//разберем примеры с протоколами и без. Сначала без

struct Human {
    var name: String
}

struct Animal {
    var name: String
}

//задача создать метод выводящий имена на экран. Тк эти структуры разные типы данных, одну и ту функцию создать нельзя

func printOutHuman (human: Human) {
    print (human.name)
}

func printOutAnimal (animal: Animal) {
    print (animal.name)
}

//теперь реализуес с протоколом

protocol Printable {
    var name: String {get}
}

struct HumanP: Printable {
    var name: String
}

struct AnimalP: Printable {
    var name: String
}

func printOutProt (object: Printable) {
    print(object.name)
}

//протокол для методов

protocol RandomNumberGen {
    func random () -> Double
}

class LetGenRandom: RandomNumberGen {
    var l = 42.0
    var a = 1204.0
    var b = 6393.0
    
    func random() -> Double {
       l = l * a - a + b
        return l/b
    }
}

let gen = LetGenRandom()
print (gen.random())
print (gen.random())
print (gen.random())

//создадим протокол метода меняющий свойства структуры или перечисления. Обязательно ключевое слово mutating

protocol Toggable {
    mutating func toggle () // для класса такой метод нельзя применять с mutating
}

enum OnOffSwitch: Toggable {
    case on, off
    
    mutating func toggle() {
        switch self { //проверяем свое заданное значение
        case .off:
            self = .on
                case .on:
                    self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
print (lightSwitch)

lightSwitch.toggle()
print (lightSwitch)

// также можно создать требования для инициализаторов

protocol SomeProtocol {
    init (somePar: Int)
}

class SomeClass: SomeProtocol {
    var test: Int
    required init(somePar: Int) {
        self.test = somePar
    }
}

//  РАСШИРЕНИЯ-  могут расширять функционал классов, структур и перечислений, а также протоколов

//расширим функционал протокола и добавим ему реализацию этого метода с пом return

extension RandomNumberGen {
    func randomBool (/* ничего не принимает)*/) -> Bool {
        print (random())
     return random() > 1000000000
    }
}

// также можно добавлять сам функционал определенного метода для протокола

print (gen.randomBool())

//с пом расширений может расширить тип данных, в самом сфивте поменять

extension Double {
    var km: Double {return self * 1000.0}
    var m: Double {return self}
    var sm: Double {return self / 100.0}
}

let a = 25.5 .km //через точку используем расширение
print (a)

let b = 345.0 .m
print (b)

let c = 10.0 .sm
print (c)

// ПОЛИМОРФИЗМ - универсальный интерфейс который сможет работать с различными типами данных, те один метод работает с разными типами данных

protocol Figure {
    func drawFiruge()
}

class rectangle: Figure {
    func drawFiruge() {
        print ("Draw a rectangle")
    }
}

class ellipse: Figure {
    func drawFiruge() {
        print ("Draw ellipse")
    }
}

class triangle: Figure {
    func drawFiruge() {
        print ("Draw triangle")
    }
}

func draw ( _ figure: Figure) { //функция вызывает фигуру, к-рая подписана протоколом
    figure.drawFiruge()  //это и есть интерфейс который может работать с любым типом данных
}
draw(ellipse())
draw(triangle())
draw(rectangle())

//композиция протоколов

protocol Named {
    var name: String {get}
}

protocol Aged {
    var age: Int {get}
}

struct personHB: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyB (to celebration: Named & Aged) {
    print("С днем рождения \(celebration.name) тебе уже \(celebration.age) !")
}

let HBSashka = personHB(name: "Сашка", age: 45)
wishHappyB(to: HBSashka)
