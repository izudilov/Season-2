import Cocoa

protocol Coffee {
    var price: Int { get }
}

class SimpeCoffee: Coffee {
    var price: Int {
        return 100
    }
}

protocol DecoratorCoffee: Coffee {
    var add: Coffee { get }
    init(add: Coffee)
}

class Shugar: DecoratorCoffee {
    var add: Coffee

    required init(add: Coffee) {
        self.add = add
    }

    var price: Int {
        return add.price + 10
    }
}

class Milk: DecoratorCoffee {
    var add: Coffee

    required init(add: Coffee) {
        self.add = add
    }

    var price: Int {
        return add.price + 20
    }
}

class Whip: DecoratorCoffee {
    var add: Coffee

    required init(add: Coffee) {
        self.add = add
    }

    var price: Int {
        return add.price + 30
    }
}

let cupOfCoffee = SimpeCoffee()
let coffeWithSugar = Shugar(add: cupOfCoffee)
let coffeWithMilk = Milk(add: coffeWithSugar)
let coffeWithWhip = Whip(add: coffeWithMilk)

print(coffeWithWhip.price)

let superCoffee = Whip(add: Milk(add: Shugar(add: SimpeCoffee())))
print(superCoffee.price)
