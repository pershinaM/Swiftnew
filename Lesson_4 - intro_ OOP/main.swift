//
//  main.swift
//  Lesson_4 - intro_ OOP
//
//  Created by Mariia on 02.11.2021.
//

import Foundation

// Три свойства ООП:

// 1. Наследование - это передача от родителя дочерним элементами каких то свойств.

// 2. Инкапсуляция - объединение свойств и поведение в единое целое. Суть - запрет на передачу некоторых параметров из одного класса в другой

class people {
    var city = "Salavat"
    private var name = "Petr" //это свойство заинкапсулировано, можем обращаться к нему только внутри класса
    
    func printHi () {
        print ("Hi \(name)")
    }
}
 let p = people ()
//p.name = "Max" //те всегда можно поменять имя, тогда паспорт и не нужен, чтобы сделать это свойство неизменяемым, нужно перед ним поставить private
//print (p.name)

p.printHi()

// 3. Полиморфизм - один из принципов ООП, позволяющий вызовом переопределённого метода через переменную класса-родителя получить поведение, которое будет соответствовать реальному классу-потомку, на который ссылается эта переменная.

// структуры и классы похожи, но и отличаются во многом
// создадим структуру с двумя свойствами
struct  Resolution {
    var  w = 0
    var h = 0
}
//создадим экзмепляр структуры
let hd = Resolution(w: 1929, h: 1080)
//создадим второй экзмемляр
var cinema = hd
//поменяем один из параметров
cinema.h = 1440 //тип ЗНАЧЕНИЕ - на нем реализуется структура
print (hd.h)
print (cinema.h)

//в классе по другому

class VideoMode {
    var f = 0.0
}

let t = VideoMode()
t.f = 1080.00

let AlsoT = t
AlsoT.f = 1440.00

print (t.f) //1440
print (AlsoT.f) // 1440

// у классов ССЫЛОЧНЫЙ тип - он не копирует, а передает ссылку

//   в классах если нет значений при инициализации, конструктор можно не создавать - в других случая init нужен



class chessman {
    let type: chessmanType
    let color: chessmanColor
    var coordinate: (String, Int)? = nil
     // перечисления являются вложенными, их можно перенести в сам класс
    enum chessmanType {
        case king, knight, queen, castle
    }
    enum chessmanColor {
        case black, white
    }
    
    init (type: chessmanType, color: chessmanColor){
        self.type = type
        self.color = color
    }
    
    // создадим инициализатор, чтобы одним шагом выводить на поле нужную фигуру
    init (type: chessmanType, color: chessmanColor, coordinate: (String, Int)){
        self.type = type
        self.color = color
        self.setCoordinate(char: coordinate.0, num: coordinate.1) // 0 указывает на string, 1 на Int)
    }
    
    // в классах mutating не используется
    final func setCoordinate (char c: String, num n: Int){
        self.coordinate = (c,n)
    }
    
    func kill (){
        self.coordinate = nil
    }
}
//чтобы ограничить типы и цвет для пользователя, введем перечисления
//1. инициализирум шахматную фигруру
var king = chessman(type: .king, color: .white)
//2. выводим на доску шахматную фигуру
king.setCoordinate(char: "A", num: 3)
//  но можно и вывести это все сразу с пом инициализатора, их может сколько можно

var queen = chessman (type: .queen, color: .white, coordinate: ("A", 4))
print (queen.coordinate)

// вот так можно вызывать пересчиления
var link = chessman.chessmanColor.black

// создадим дочерний класс

class someSubClass: chessman {
    
    func printChessmanType (){
        print(self.type)
    }
    
    //можно переписать функцию от родителя с пом override
   // override func setCoordinate(char c: String, num n: Int) {
      //  self.coordinate = (c, n*2)
    //print (self.coordinate)
   // }
    //чтобы сделать метод неизменяемым  - у родителя нужно поставить final перед func
    
}

var castle = someSubClass (type: .castle, color: .black)
castle.setCoordinate(char: "F", num: 5)
castle.printChessmanType()

// queen.printChessman.Type - ошибка, тк метод не принадлежит родит классу


// deinit деинициализатор можетбыть только один. Нужен когда класс удаляется из памяти нашего устройства. В отличие от структур, классы имеют не только конструктор, но и деструктор. Правда, уничтожить класс деструктор не может – этим занимается среда выполнения. Зачем же он тогда нужен?
//В Swift деструктор называется «deinit». Вы можете определить его у любого класса, но не можете его вызвать. Вызывает этот метод среда выполнения. Вы же можете описать в нем действия, которые необходимо выполнить в момент, когда объект удаляется из памяти.

class superClass {
    init? (isNil: Bool){
        if isNil == true {
            return nil
        } else {
            print("Экземпляр создан")
        }
    }
    
    deinit {
        print ("Класс deinit")
    }
}

class subClass: superClass{
    deinit{
        print ("Sub class deinit")
    }
}

var obj = subClass(isNil: false)
 
//удалим obj

obj = nil  //так можно очищать память

class person {
    let name: String
    init (name: String){
        self.name = name
        print("\(name) init")
    }
    
    deinit {
        print ("\(name) deinit")
    }
}

//cоздадим обьекты и не проинициализируем их

var ref1: person? = nil
var ref2: person? = nil
var ref3: person? = nil

ref1 = person(name: "Person1")
ref2=ref1
ref3=ref1 //  на консоле одна  Person init,потому что все три рефа ссылаются на первый
// [ref1 ref2 ref3] [person]

//начнем удалять рефы, если удалить только два из трех -  ARS видит ссылку на третий и не удаляет из памяти, но как только третий удаляет, срабатывате deinit

 ref1 = nil
ref2 = nil
ref3 = nil // на консоле Person DEINIT


// Утечка памяти - решается с помощью   WEAK

class Human {
    let name: String
    var child = [Human]()
     weak var father: Human? //weak говорит, что ARSудалит эти ссылки первыми
    weak var mother: Human?
    
    init (name: String){
        self.name = name
        print ("\(name) init")
    }
    
    deinit {
        print( self.name + " kill")
    }
}

if 1==1 {
    let kirill = Human (name: "Кирилл")
    let olga = Human (name: "Ольга")
    let alex = Human (name: "Алекс")
    
    kirill.father = alex
    kirill.mother = olga
    
    alex.child.append(kirill)
    olga.child.append(kirill)
    
}
