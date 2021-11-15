//
//  main.swift
//  catch
//
//  Created by Mariia on 14.11.2021.
//

import Foundation

//  error

var isIncontrol = true

func selfDrive() {
    
    if isIncontrol {
        print("Evrything is good")
    } else {
        print("Evrything is bad")
    }
}

selfDrive()

//apple рекомендует испрльзовать протокол ERROR


//задача: есть машина тесла и нам необходимо создать возможные ошибки и  обработать их. допустим обработать ошибки когда потерян  GPS и когда разаряжена батарея
var lostGPS: Bool = true
var lowBattery:Bool = false

func autoDriveTesla() { //создадим функцию где проверим эти ошибки и обработаем(принт)
    
    if lostGPS {
        print ("we are lost")
    }
    
    if lowBattery {
        print ("The battery is dead")
    }
}

// Если будем использовать Error Handling как рекомендует Apple, используем следующее: ключевое слово Throws
enum TeslaError: Error { //этот протокол содержит список ошибок, которые можно обработать
    case LostGPS         // этот протокол пустой, не заставляет создавать переменные
    case lowbattery
}

/*throws - ключевое слово которое пишетсяя в функции, которая булет выбрасывать ошибку
Если пометить метод этим ключевым словом, мы однозначно покажем, что он может содержать ошибку и ее надо обработать. Мы просто не оставим пространства для маневра тому, что вызовет наш метод.
Все методы, помеченные как «throws», должны возвращать исключение. Исключения – это ошибки, имплементирующие протокол «Error», но не просто возвращаемые, а сгенерированные в исключительную ситуацию. Чтобы сгенерировать ошибку, необходимо  использовать ключевое слово «throw». */

func autoDrive() throws { // метод , который мы сказали что произошла ошибка, но ничего не сделали чтобы устранить ее и показать пользователю
    
    if lostGPS {
        throw TeslaError.LostGPS
    }
    
    if lowBattery {
        throw TeslaError.lowbattery
    }
    
    print("Evrything is all right")

}
//для того, чтобы обработать ошибку испольузем прием try/catch
do {
    try autoDrive() // в блоке do запустим метод который будет выдавать ошибку
} catch TeslaError.LostGPS { //проверим ошибку и выведем для пользователя инфо, обработаем ее
        print("You are lost")
    } catch TeslaError.lowbattery {
        print("The batteri is dead")
    }

// рассмотрим другой пример
//перечислим возможные ошибки

enum jsonDownload: Error {
    case moreSizeFileDownload
    case noNameFiles
    case serverError(error: Int)
}

//создадим структуру где пропишем имя и размер файла
struct File {
    var image: String
    var size: Int
}

class downloadJPEG {
    var fileDownload = [
        "dog.jpeg": File(image: "dog", size: 3),
        "cat.jpeg": File (image: "cat", size: 9),
        "car.png": File(image: "car", size: 1)
    ]
    
    var sizeDownload = 7
    var errorValue = 404
    
    func downloadItem(itemNamed name: String, error: Int) throws {
        
        //guard похож на if-else, отлчие в том, что в guard создаем переменную, которую проверяем и потом можем работать с ней дальше по коду, а в if-else с переменной можем работать в самом  if-else
        
        guard let file = fileDownload[name] else { // проверяем заданный файл и если есть ошибка - выбрасываем эту ошибку, н-р что нет такого имени файла
            throw jsonDownload.noNameFiles
        }
        
        //если все таки мы нашли эту картинку, проверям ее размер
        
        guard file.size < sizeDownload else {
            throw jsonDownload.moreSizeFileDownload
        }
        
        guard errorValue == 200 else {
            throw jsonDownload.serverError(error: errorValue)
        }
        
        print( "\(file.image) is downloaded. Size is \(file.size)")
    }
}

//создадим коллекцию - опишем то куда будем загрудать наши картинки

let UICollection = [
    "TableView": "dog.jpeg",
    "TabBar": "cat.jpeg",
    "ScrollView": "car.png"
]

// опишем функцию загрузки, если в ней вызываем метод, который выбрасывает ошибки, то и этот метод доджен быть помечене ключ словом  throws

func download(collection: String, funcDownload: downloadJPEG) throws {
    let serverMessage = 200
    let collectionView = UICollection[collection] ?? "Loadscreen" // если нет какого элемента в коллекции, то загружаем на экран загрузкиloadscreen- это на экране первый появляется в любом приложении. Обычно там распрологается логотип компании или самого приложения
    //проверяем метод
    
    try funcDownload.downloadItem(itemNamed: collectionView, error: serverMessage)
    
}

//теперь надо обработать ошибки  с помощью  do-catch

do {
    try download(collection: "TableView", funcDownload: downloadJPEG())
} catch jsonDownload.moreSizeFileDownload {
    print("The size of the file is more than needed")
} catch jsonDownload.noNameFiles {
    print("There ia no such a file")
} catch jsonDownload.serverError(let error) {
    print( "Error\(error)")
}

//APPLE рекомендуте обрабатывать ошибки не там где они произошли в do-catch

// TRY-CATCH

//try?

//напишем метод который возвращает ошибку, внутри напишем что будет возвращать 10 или нил
func someThrows() throws -> Int {
    return 10
}
//получили ошибку от этого метода
var y: Int?

do {
    y = try someThrows() //если метод возвращает нам значение, записываем его в y
} catch { //если метод вернул ошибку, говорим что у равен нил
    y = nil
}
// вторая форма записи

let x = try? someThrows()


// другой пример

enum passwordError: Error {
    case obvious
}

func checkPassword (_ password: String) throws -> Bool {
    if password != "password" {
        throw passwordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
        print("Password is right")
} catch {
        print("error")
    }

//иначе другая форма записи с try?

if let result = try? checkPassword("password") {
    print("result is \(result)")
} else {
    print("errorrr")
}

// еще один try! -принудительно распаковывает, но очень опасно, может уронить программу. Используется если точно знаем, что подходит. Например загрузим фото без доп проверок

//let photo = try! loadImage(at path: "resourse/car.png")


// EXAMPLE

var array: [String] = ["🔥", "🔥", "🔥", "☀️", "❄️"]

print(array)

// заменим элементы с пом map

print(array.map {_ in "🌗"}) // ["🌗", "🌗", "🌗", "🌗", "🌗"]

//используем фильтр - нужно найти например то что огонь и отобразить это

print(array.filter{ i in i == "🔥"}) //["🔥", "🔥", "🔥"]

// reverse -меняет порядок
array.reverse()
print(array) // ["❄️", "☀️", "🔥", "🔥", "🔥"]

//contains  - проверяет содержится ли в массиве элемент

print( array.contains { i in i == "🔥"}) // true

//prefix and suffix -выводит первые и последние эелементы массива
 print(array.prefix(2)) // ["❄️", "☀️"]
print(array.suffix(4)) // ["☀️", "🔥", "🔥", "🔥"]

// метод меняющий эелементы метсами SwapAt

array.swapAt(0, 3)
print(array) // ["🔥", "☀️", "🔥", "❄️", "🔥"]

//shuffle рандомно выводит значения на экран

array.shuffle()
print(array) // ["🔥", "☀️", "🔥", "🔥", "❄️"]

//удаление эелементов массива

print( array.dropLast(2))
print(array) // ["❄️", "☀️", "🔥"]
             //["❄️", "☀️", "🔥", "🔥", "🔥"]

print(array.dropFirst(3))
print(array) // ["🔥", "🔥"]
             //["🔥", "☀️", "❄️", "🔥", "🔥"]


print(array.removeAll{i in i == "🔥"})
print(array) // ()
             //["❄️", "☀️"]

print(array.removeAll())
print(array) // ()
             //[]
