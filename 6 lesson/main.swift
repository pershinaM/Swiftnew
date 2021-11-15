//
//  main.swift
//  6L_PershinaMariia_HomeWorl
//
//  Created by Mariia on 10.11.2021.
//

import Foundation
/* 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.*/


struct Queue <T> {
    var list = [T]()
    
    mutating func enqueue ( _ item: T){
        return list.append(item)
    }
    
    mutating func dequeue() -> T? {
        if !list.isEmpty { //  проверим если лист непустой, то удаляем первый индекс
            return list.removeFirst()
        } else {
            return nil
        }
    }
    //функция показывает если лист не пустой, то показывает первый элемент массива
    func peek() -> T? {
        if !list.isEmpty {
            return list [0]
        } else {
            return nil
        }
    }
    //проверим статут нашего листа
    var isEmpty: Bool {
        return list.isEmpty
    }
    
    func filter(predicate: (T) -> Bool) -> [T] {
        var tmpArray = [T]()
        for item in list {
            if predicate(item) {
                tmpArray.append(item)
            }
        }
        return tmpArray
    }
    
    func map (item: T) {
        print("При умножении каждого элемента на 2 получим коллекцию \(list.map {($0 as! Int * 2)} )")
    }
    
    subscript (index: Int) -> T? {
        return (index < list.count ? list [index]: nil)
    }
}


var collection = Queue<Int>()


collection.enqueue(5)
collection.enqueue(8)
collection.enqueue(15)
collection.enqueue(35)
collection.enqueue(66789)
collection.enqueue(1578908890)
print(collection)

collection.dequeue()

print(collection)

collection.peek()
print(collection)


let col = collection.filter(predicate: {(item: Int) -> Bool in
    return item % 2 == 0
})
print(col) //[8, 1578908890]

print(collection.map(item: 2)) //При умножении каждого элемента на 2 получим коллекцию [16, 30, 70, 133578, 3157817780]


