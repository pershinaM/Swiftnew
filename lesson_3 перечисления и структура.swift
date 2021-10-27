//
//  main.swift
//  lesson_3_Перечисления_структура
//
//  Created by Mariia on 26.10.2021.
//

import Foundation

// Перечисления
//– это тип, объединяющий набор простых констант. Вы можете их использовать, чтобы код лучше читался и был менее подвержен ошибкам.

//создадим учет денежных едениц. Нескоолько способов

// такой способ не всегда удобен: могут возникунть ошибки в написании, переменные срабатывают одна за другой и тп
var RussianCurrency: String = "Rouble"
var dollarCur = "Dollar"
var euro: String = "Euro"

// второй способ - массивы, но там неудобно вызывать по индексам

var currencyArrey: [String] = ["Rouble","Dollar","Euro"]
print (currencyArrey[0])

// третий способ - перечисления ENUM, которые содержат альтернативные варианты, содержащие те или иные параметры
//Перечисления являются абстрактным типом данных, типа String, Int ets.

enum currency_enum {
    case Rouble
    case Dollar
    case Euro
}
// обращения могут быть 2х видов или или

var rouble: currency_enum = .Rouble
var dollar = currency_enum.Dollar

//создадим другое перечисление. Вызывать переичсления можно только те, которые в нем записаны - еще раз защищает нас от ошибок

enum Activity {
    case Walk (meters: Int) // ассоциативные параметры
    case Run (meters: Int, speed: Int)
    case Stop
    case Turn (direction: Direction)
    
    enum Direction: String {
        case left = "Left"
        case right = "Right"
    }
    
/*    enum Activity2 {
        case Fly
        case Jump
    }*/
}
 
var activity = Activity.Run(meters: 1000, speed: 10) //полную версию написали только один раз, дальше Свифт понимает
//activity = .Stop
//activity = .Turn
//activity = .Walk(meters: 100)
activity = .Turn(direction: .right)

/*var activity2 = Activity.Activity2.Fly //удобно и когда одно перечисление в другом писать только один раз весь адрес
activity2 = .Jump*/

// переменные может обработать с помощью  Switch Case

switch activity {
    case .Stop:
        print ("STOP")
    case .Walk(let meters) where meters < 500 :
        print ("Short distance \(meters)")
    case .Walk:
        print ("Long distance")
    case .Run(let met, let speed):
        print ("\(met) \(speed)")
    case .Turn( let dir) where dir == .left:
        print(dir.rawValue) // rawValue - то значение, к-рое мы передали для работы, исключает ошибки
case .Turn(let dir) where dir == .right:
        print(dir.rawValue)
    default:
        break
}
 // перечисления используются н-р когда мы собираем ошибки, или перечисляем роли: администратор и тп для польователя. Если есть покупки, то перечисляем данные покупки и тп

print ("▄■▀■▄■▀■▄■▀■▄☼ ЧуДеСнОгО ДнЯ ☼▀■▄■▀■▄■▀■▄■▀")

// СТРУКТУРЫ  нужны чтобы осздать скелет программы, описывающая некую сущность

struct playerInChess {
    
    // свойства структуры - те же самые переменные и константы, с пом к-рых будем писать код
    var name: String // = " " // можем значение по умолчанию оставить или присвоить что то
    var wins: Int // = 1 - переписали в конструктор init
    
    // методы - те же самые функции, только внутри структуры
    
    func description () {
        print( "Игрок \(name ) выиграл \(wins)")
    }
    
    mutating func addWins(wins: Int){ // добавляем mutating тк изменяем св-во wins
        self.wins += wins // self отличает входной от внутр параметра
    }
    
    // конструктор нужен для того, чтобы написать часть в скобках, к-рая вызывется при обращении к экземпляру
    
    init (namePlayer: String, winsPlayer: Int) {
        self.name = namePlayer
        self.wins = winsPlayer + 10
    }
    
    init () {
        self.name = ""
        self.wins = 1
    }
    
    init (namePlayer: String) {
        self.name = namePlayer
        self.wins = 110 // кол-во побед по умолчанию, при вызове только имя нужно вписать
    }
}

// создадим ЭКЗЕМПЛЯР СТРУКТУРЫ, к-рый содержит уник св-ва, с к-рыми мы будем в дальнейшем работать

var Oleg: playerInChess = playerInChess() // значени по умолчанию, 2ая функция пустая init
print (Oleg)

var Max: playerInChess = playerInChess(namePlayer: "Maxim", winsPlayer: 10) //  передали уник свойство по шаблону
print (Max)

var Max2: playerInChess = playerInChess(namePlayer: "Super_Max")
Max2.description()
    
var Arthur: playerInChess = playerInChess(namePlayer: " Артур", winsPlayer: 13)

//сравним одно свойство у экзмепляров, например победы

if Max.wins > Arthur.wins {
    print("Макс играет лучше")
} else if Max.wins < Arthur.wins {
    print ("Артур играет лучше")
}

print(Max.name)

// можем вывести вот так инф-цию, но не удобно, тк может много экземпляров, поэтому используют фунцкцию внутри структуры
print( "Игрок \(Max.name ) выиграл \(Max.wins)!!!")
print( "Игрок \(Arthur.name ) выиграл \(Arthur.wins)!!!")

//получим инф-цию с пом вызова функции, запись лаконичнее

Max.description()
Arthur.description()

Max.addWins(wins: 4)
Max.description()


print ("▄■▀■▄■▀■▄■▀■▄☼ ЧуДеСнОгО ДнЯ ☼▀■▄■▀■▄■▀■▄■▀")

//example - нужно загрузить данные с сайта о биткоине и структурировать ее

let urlBitcoin: String =
    "https://www.cryptingup.com/api/markets"

//  cделаем из нее настоящую раб ссылку с пом  URL

let urlBit = URL(string: urlBitcoin)

// чтобы загрузить данные из интернета испо-ем спец функцию

URLSession.shared.dataTask(with: urlBit!) { (data, response, error) in
    if let data = data {
        let jsonString = String(data: data, encoding: .utf8) // откуда и во что конвертируем
        print (jsonString!)
    } else {
        print (error!)
    }
}.resume() // запускает с пом resume, чтоб все заработало

//чтобы все структурировать, создадим структуру
 
struct Bitcoin: Decodable {
    var markets = [Markets]()
}

struct Markets: Decodable {
    let symbol: String
    let price: Double
    let change_24h: Double
}

URLSession.shared.dataTask(with: urlBit!){(data, response, error) in
    guard let data = data else {return}
    
    do {
        let market = try JSONDecoder().decode(Bitcoin.self, from: data)
        print(market)
        for i in 0...10 {
            print (i)
            print ("----------")
            print (market.markets[i].symbol)
            print (market.markets[i].price)
        }
    } catch {
        print ("error")
    }
    
} .resume()
