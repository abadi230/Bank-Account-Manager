import Foundation

struct Transaction{
    var id: Int, amount: Double, date: Date
    init(id: Int, amount: Double, date: Date = Date()) {
        self.id = id
        self.amount = amount
        self.date = date
    }
}

struct Account {
    
    private var transactions = [Transaction]()
    enum AccountType { case normal, VIP }
    var id: Int
    var name : String, password: String
    var amount : Double
    
    
    
    
    
    var type : AccountType
    
    init(id: Int, name: String, amount: Double){
        self.id = id
        self.name = name
        self.password = "Password"
        self.amount = amount
        self.type = .normal
        checkType()
    }
    private mutating func checkType(){ // tuggle between AccountType enum
        if amount < 1000000 {
            type = .normal
        } else { type = .VIP }
    }
    func getAccount(password: String){ // display account name and amount
        if checkPassword(password: password) {
            print("Account name: \(name), Amount: \(amount)")
        } else { print("Password Not Valid!!") }
        
    }
    
    private mutating func addTransaction(newTrans: Transaction){
        transactions.append(newTrans)
    }
    
    mutating func deposit(transaction: Transaction) { // add money to amount
        addTransaction(newTrans: transaction)
        amount += transaction.amount
        print("Total amount in your \(name) account is \(amount)")
    }
    mutating func withdraw(transaction: Transaction, password: String) { // Deduct money from amount
        
        if checkPassword(password: password) && checkPalance(amount: transaction.amount){
            switch type {
            case .normal:
                if transaction.amount <= 10000 {
                    addTransaction(newTrans: transaction)
                    amount -= transaction.amount
                } else { print("Maximum limit is 10000")}
                
            case .VIP:
                addTransaction(newTrans: transaction)
                amount -= transaction.amount
            }
            
        } else { print("Transaction Not Accepted")}
        
        print("Total amount in your \(name) account is \(amount)")
    }
    
    func getAllTransactions(){ // dispaly all transaction
        print("Transaction in \(name) Account:")
        transactions.map{
            print("ID: \($0.id) Palance: \($0.amount) Date: \(date_format(date: $0.date))")
        }
    }
    
    mutating func setPassword(password: String) {
        if isValidPassword(password: password) {
            print("Password is Accepted")
            self.password = password
        } else { print("Password Not Accepted. Password must be more than 6 characters, with at least one capital, numeric or special character ")}
    }
    
    private func isValidPassword(password: String) -> Bool{
        // regex : Password must be more than 6 characters, with at least one capital, numeric or special character
        let passwordRegEx = "(?:(?:(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_])|(?:(?=.*?[0-9])|(?=.*?[A-Z])|(?=.*?[-!@#$%&*ˆ+=_])))|(?=.*?[a-z])(?=.*?[0-9])(?=.*?[-!@#$%&*ˆ+=_]))[A-Za-z0-9-!@#$%&*ˆ+=_]{6,15}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    private func checkPassword(password: String) -> Bool{
        return self.password == password
    }
    private func checkPalance(amount: Double) -> Bool{
        return self.amount > amount
    }
    func date_format(date: Date ) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm"
        
        return dateFormatterGet.string(from: date)
    }
    
}


class User {
    
    var name : String
    var accounts = [Account]() // array of Account struct
    
    
    init(name: String) {
        self.name = name
    }
    
    func getAllAccounts() {
        if self.accounts.isEmpty { // check accounts array
            print("User not exist")
        }else{
            self.accounts.map{ account in // loop to display each account in accounts array
                print("\(name) has account in \(account.name) with Amount of \(account.amount)")
            }
            print("Total Amount is: \(getTotalAmounts())")
        }
    }
    
    func addAccount(newAccount: Account){ // add a new account to accounts array
        accounts.append(newAccount)
    }
    func getTotalAmounts() -> Double {// print total amount
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
        
        print("\(accounts[index].name) Account is deleted")
        accounts.remove(at: index)
    }
    func updateAccount(id: Int, account: Account){
        guard let index = findIndexBy(id: id) else { return  }
        
        print("\(accounts[index].name) Account is Updated")
        accounts[index] = account
    }
    
    
}


var abdullah = User(name: "Abdullah") // create User instance
/* create Account instance */
var ahli = Account(id: 101, name: "Al-Ahli", amount: 2000000.79)
var rajhi = Account(id: 102, name: "Al-Rajhi", amount: 50000.35)
var belad = Account(id: 103, name: "Al-Belad", amount: 200.50)

/* Add Account to User instance */
abdullah.addAccount(newAccount: ahli)
abdullah.addAccount(newAccount: rajhi)
abdullah.addAccount(newAccount: belad)

// display all Accounts
abdullah.getAllAccounts()

/* set and test Password*/
ahli.getAccount(password: "Password") // default Password
rajhi.setPassword(password: "Abc1228")



// check Account Type
rajhi.type
ahli.type

/* make transaction and test it */
var today = Date() // instance from Data struct

var formatter = DateFormatter() // instance from DateFormatter class
formatter.dateFormat = "dd/MM/yyyy HH:mm"

// variables contain different year, month and day to test sort transactions
var date1 = Calendar.current.date(byAdding: .year, value: 2, to: today)!
var date2 = Calendar.current.date(byAdding: .day, value:  -2, to: today)!
var date3 = Calendar.current.date(byAdding: .day, value:  -3, to: today)!
var date4 = Calendar.current.date(byAdding: .day, value:  1, to: today)!
var date5 = Calendar.current.date(byAdding: .month, value: -5, to: today)!

// create transactions instance with default date
var transaction1 = Transaction(id: 01, amount: 10001) // test withdraw more than 10000
var transaction2 = Transaction(id: 02, amount: 500)
var transaction3 = Transaction(id: 03, amount: 6000)
// create transactions with costum date
var transaction4 = Transaction(id: 04, amount: 8000, date: date2)
var transaction5 = Transaction(id: 05, amount: 700, date: date1)
var transaction6 = Transaction(id: 06, amount: 6000, date: date5)

// use transactions
rajhi.withdraw(transaction: Transaction(id: 04, amount: 200), password: "Abc1228")
rajhi.withdraw(transaction: transaction1, password: "Abc1228")
rajhi.withdraw(transaction: transaction2, password: "Abc1228")
rajhi.withdraw(transaction: transaction3, password: "Abc1228")

ahli.deposit(transaction: transaction4)
ahli.deposit(transaction: transaction5)
ahli.deposit(transaction: transaction6)

ahli.withdraw(transaction: transaction1, password: "Password")
ahli.withdraw(transaction: transaction2, password: "Password")


// remove account
abdullah.removeAccount(id: 10) // not existed id
abdullah.removeAccount(id: 102) //
abdullah.getAllAccounts() // check all accounts

// update account
abdullah.updateAccount(id: 103, account: Account(id: 103, name: "Lloyds", amount: 500))
abdullah.getAllAccounts()
/*  Add extension to Account to sort transactions */
extension Account {
    func sortedTransaction(){
        
        let sortedTr = self.transactions.sorted{
            $0.date < $1.date
        }
        
        sortedTr.map{
            print("ID: \($0.id) Palance: \($0.amount) Date: \(date_format(date: $0.date))")
        }
    }
}
ahli.sortedTransaction()
