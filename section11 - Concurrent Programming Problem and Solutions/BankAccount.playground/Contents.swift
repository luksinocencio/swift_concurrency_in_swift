import UIKit

class BankAccount {
    var balance: Double
    let lock = NSLock()
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(_ amount: Double) {
        lock.lock()
        if balance >= amount {
            let processingTIme = UInt32.random(in: 0...3)
            print("[Withdraw] Processing for \(amount) \(processingTIme) seconds")
            sleep(processingTIme)
            balance -= amount
            print("Balance is \(balance)")
        }
        lock.unlock()
    }
}

let bankAccount = BankAccount(balance: 500)
let queue = DispatchQueue(label: "SerialQueue")

queue.async {
    bankAccount.withdraw(300)
}

queue.async {
    bankAccount.withdraw(500)
}
