import Foundation

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
 */

class Person {
    /*
     to do:  # sort by date
     # removeAccount: try catch
     */
    
    
    var name : String
    var accounts = [Account]()
    
    
    init(name: String) {
        self.name = name
    }
    
    func getAllAccounts() {
        // add try catch
        self.accounts.map{ account in
            print("\(name) has account in \(account.name) with Amount of \(account.amount), Opening Account at \(account.date)")
        }
        print("Total Amount is: \(getTotalAmounts())")
    }
    func getTotalAmounts() -> Double {
        return self.accounts.map{$0.amount}.reduce(0, {$0 + $1})
    }
    func removeAccount(name: String){
        guard let deleteAccount = accounts.firstIndex(where: {$0.name == name}) else {
            print("No \(name) Account in your Accounts ")
            return }
        accounts.remove(at: deleteAccount)
    }
    func transfare(money: Double, to: String){
        accounts.firstIndex(where: {$0.name == to})
    }
    
}


 struct Account {
     /* to do:
      @ date
      @ account type: enum personal, business, saving
      # transfare money to other person : cash , online
      
      */
     var name : String, amount : Double, date: Date
     enum AccountType {
         case personal
         case cach
         case online
     }
     
    
    init(name: String, amount: Double){
        self.name = name
        self.amount = amount
        self.date = Date()
    }
     func getAccount(){
         print("Account name: \(name), Amount: \(amount), time created this account: \(date)")
     }
    mutating func deposit(money: Double) {
        amount += money
        print("Total amount in your \(name) account is \(amount)")
    }
    mutating func withdraw(money: Double){
        self.amount -= money
        print("Total amount in your \(name) account is \(amount)")
    }
    
}

var abdullah = Person(name: "Abdullah") // person name

var ahli = Account(name: "Al-Ahli", amount: 20000.79)
var rajhi = Account(name: "Al-Rajhi", amount: 5000.35)
var belad = Account(name: "Al-Belad", amount: 200.50)
abdullah.accounts.append(ahli)
abdullah.accounts.append(rajhi)
abdullah.accounts.append(belad)

abdullah.getAllAccounts()
//abdullah.accounts[0].deposit(money: 300) //deposit from Person instance
rajhi.withdraw(money: 200)
//abdullah.getAllAmounts()

// remove account
abdullah.removeAccount(name: "hi")
//abdullah.getAllAccounts()

var ali = Person(name: "Ali")
var jazira = Account(name: "Al-Jazira", amount: 400)
jazira.date

ali.getAllAccounts()
ali.getTotalAmounts()



//let findAccount = abdullah.accounts.filter{$0.name == "Al-Rajhi"}
//findAccount[0].amount

