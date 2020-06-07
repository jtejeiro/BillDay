
import Foundation


struct BillViewModel {
    let billResponse:BillResponse
    let billValide: BillResponse
    let billSorted: BillResponse
    let billDepurate:BillResponse
    let firstBill:BillResponseElement
    let otherBillArray:BillResponse
    
    
    static func mapperToBillResponse(response:BillResponse) -> BillViewModel {
        let arrayValide:BillResponse = setBillValide(response: response)
        let arraySorted:BillResponse = setBillSorted(valide: arrayValide)
        let arrayDepurate:BillResponse = setBillDepurate(Sorted: arraySorted)
        let firstElement = arrayDepurate.first ?? BillResponseElement()
        let otherElement = arrayDepurate.filter({ $0 !== firstElement })
        return BillViewModel(billResponse: response , billValide: arrayValide , billSorted: arraySorted, billDepurate: arrayDepurate , firstBill: firstElement, otherBillArray: otherElement)
    }
    
    // filtra arreglo de elementos con fecha corructa
    static func setBillValide(response:BillResponse)->BillResponse {
        let array:BillResponse = response.filter({ $0.isValideFormatterDate().rawValue == TypeValideDate.valide.rawValue })
        return array
    }
     
    //ordena arreglo de elementos con fecha reciente
    static func setBillSorted(valide:BillResponse)->BillResponse {
        let array:BillResponse = valide.sorted(by: {
            $0.getDateFormatter().compare($1.getDateFormatter()) == .orderedDescending})
           return array
    }
    
    //selecciona los elementos con id igual y muestra el mas reciente 
    static func setBillDepurate(Sorted:BillResponse)->BillResponse {
        var array:BillResponse = BillResponse()
        for element in Sorted {
            if array.contains(where: {$0.id == element.id}) {
                let filter :BillResponse = Sorted.filter({ $0.id == element.id })
                if let first = filter.sorted(by: {
                    $0.getDateFormatter().compare($1.getDateFormatter()) == .orderedDescending}).first {
                    let n = array.firstIndex(where: { $0.id == first.id}) ?? 0
                    array[n] = first
                }
            } else {
                array.append(element)
            }
        }
        return array
    }
    
    
}

