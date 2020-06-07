
import Foundation

enum TypeValideDate: String, CodingKey {
    case valide
    case null
}

enum TypeAmountBill: String, CodingKey {
    case Positive
    case neutral
    case Negative
}

class BillResponseElement: Codable {
    var id: Int
    var date: String
    var amount: Double
    var fee: Double?
    var billDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, date, amount, fee
        case billDescription = "description"
    }
    
    init() {
        self.id = 0
        self.date = "000"
        self.amount = 000.0
        
    }
    
    init(id: Int, date: String, amount: Double, fee: Double?, billDescription: String?) {
        self.id = id
        self.date = date
        self.amount = amount
        self.fee = fee
        self.billDescription = billDescription
    }
     
    func getTotalValue() -> Double  {
        return amount + (fee ?? 0.0)
    }
    
    ///TODO::  sustituir por extensiones
    func getTotalString() -> String {
        return String("\(getTotalValue())\(Kconstants.KGlobalCurrency) ")
    }

    func getfeeString() -> String {
        return String("\(fee ?? 00.0)\(Kconstants.KGlobalCurrency)")
    }
    
    func getAmountString() -> String {
        return String("\(amount)\(Kconstants.KGlobalCurrency)")
    }
    
    func getTypeAmount() -> TypeAmountBill {
        if getTotalValue() == 0 {
            return .neutral
        }else if getTotalValue() > 0 {
            return .Positive
        } else {
            return .Negative
        }
    }
    
    func isValideFormatterDate() -> TypeValideDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Kconstants.KDateFormatResponse
        if dateFormatter.date(from:self.date) != nil{
            return .valide
        }else {
            return .null
        }
    }
    
    func getDateFormatter() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Kconstants.KDateFormatResponse
       if let ldate = dateFormatter.date(from:self.date){
            return ldate
        }else {
            return Date()
        }
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Kconstants.KDateFormatBill
        return dateFormatter.string(from: getDateFormatter())
    }
    
    
}

typealias BillResponse = [BillResponseElement]
