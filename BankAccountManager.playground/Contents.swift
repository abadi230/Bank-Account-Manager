import Foundation
import CoreGraphics

/*
 Bank Account Manager
 User Story
 As a user, I should be able to create a new person✅
 As a user, I should be able to create a new account✅
 As a user, I should be able to display all accounts✅
 As a user, I should be able to deposit money✅
 As a user, I should be able to withdraw money✅
 As a user, I should be able to delete account✅
 As a user, I should be able to sort by date
 As a user, I should be able to transfare money to other person
 
 ************ enum , extend sort,
 vip costumer can make tracaction more than normal account
 */

class Person {
    /*
     # removeAccount: try catch
     */
    var name : String
    var accounts = [Account]() // array of Account struct
    
    
    init(name: String) {
        self.name = name
    }
    
    func getAllAccounts() {
        // add try catch
        self.accounts.map{ account in // loop to display each account in accounts array
            print("\(name) has account in \(account.name) with Amount of \(account.amount)")
        }
        print("Total Amount is: \(getTotalAmounts())")
    }
    
    func addAccount(newAccount: Account){ // add a new account to accounts array
        accounts.append(newAccount)
    }
    func getTotalAmounts() -> Double {//??? print total amount person has more than 1  account
        let numAccount:Double
        if accounts.count > 1 {
            numAccount = accounts.map{$0.amount}.reduce(0, {$0 + $1})
        } else { numAccount = accounts[0].amount}
        return numAccount
    }
    private func findIndexBy(id: Int) -> Int?{ // return index of accounts array
        guard let id = accounts.firstIndex(where: {$0.id == id}) else {
            print("No Account with id: \(id)")
            return nil
        }
        return id
    }
    func removeAccount(id: Int){ // remove account by id
        guard let index = findIndexBy(id: id) else { return  }
        accounts.remove(at: index)
    }
    
    
}

struct Transaction{
    var id: Int, amount: Double, date: Date
    init(id: Int, amount: Double, date: Date) {
        self.id = id
        self.amount = amount
        self.date = Date()
    }
}

 struct Account {
     /* to do:
      @ date
      @ account type: enum personal, business, saving
      # tranactions to other person : cash , online
      
      */
     
     var transactions = [Transaction]()
     enum AccountType {
         case normal
         case VIP
     }
     var id: Int
     var name : String, password: String
     var amount : Double
     var type : AccountType
     
     init(id: Int, name: String, amount: Double){ // id should be uniqe
         self.id = id
         self.name = name
         self.password = "Password"
         self.amount = amount
         self.type = .normal
     }
     func getAccount(){ // display account name and amount
         print("Account name: \(name), Amount: \(amount)")
     }
     
     private mutating func addTransaction(newTrans: Transaction){
         transactions.append(newTrans)
     }
     mutating func deposit(transaction: Transaction) { // add money to amount
        addTransaction(newTrans: transaction)
         amount += transaction.amount
        print("Total amount in your \(name) account is \(amount)")
    }
    mutating func withdraw(transaction: Transaction) { // add money to amount
        // if no money
        addTransaction(newTrans: transaction)
         amount -= transaction.amount
        print("Total amount in your \(name) account is \(amount)")
    }
     //  password: String,type: AccountType
     func setPassword(password: String) {
         print(chekPassword(password: password) ? password : "Password Not Valid!!")
         
     }
     func chekPassword(password: String) -> Bool{
         // regex : Password must be more than 6 characters, with at least one capital, numeric or special character
         let passwordRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
         let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
         return passwordTest.evaluate(with: password)
     }
}



var abdullah = Person(name: "Abdullah") // create Person instance

var ahli = Account(id: 101, name: "Al-Ahli", amount: 20000.79) //create Account instance
var rajhi = Account(id: 102, name: "Al-Rajhi", amount: 5000.35)
var belad = Account(id: 103, name: "Al-Belad", amount: 200.50)

abdullah.addAccount(newAccount: ahli)
abdullah.addAccount(newAccount: rajhi)
abdullah.addAccount(newAccount: belad)
abdullah.getAllAccounts()
//abdullah.accounts[0].deposit(money: 300) //deposit from Person instance

rajhi.setPassword(password: "Abc1228")
rajhi.withdraw(transaction: Transaction(id: 01, amount: 500, date: Date()))

//abdullah.getAllAmounts()

// remove account
abdullah.removeAccount(id: 10)
//abdullah.getAllAccounts()
//print(abdullah.accounts.firstIndex(where: {$0.name == "Al-Rajhi"})!)

var ali = Person(name: "Ali")
var jazira = Account(id: 104, name: "Al-Jazira", amount: 400)
ali.addAccount(newAccount: jazira)
//
ali.getAllAccounts()
ali.getTotalAmounts()

/* test transaction */
abdullah.accounts[0].deposit( transaction: Transaction(id: 1, amount: 99, date: Date()))
//let findAccount = abdullah.accounts.filter{$0.name == "Al-Rajhi"}
//findAccount[0].amount
