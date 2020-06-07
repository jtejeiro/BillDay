
@testable import BillDay
import XCTest

class BillViewModelTest: XCTestCase {
    
    var billVM : BillViewModel!
    var MockInteratorArray:BillResponse = BillResponse()
    
    override func setUp() {
        super.setUp()
        MockInteratorArray = [
            BillResponseElement(id: 1234, date: "2018-07-11T22:49:24.000Z", amount: 110.0, fee: -10.0, billDescription: "prueba"),
            BillResponseElement(id: 1234, date: "2018-02-11T22:49:24.000Z", amount: -110.0, fee: -10.0, billDescription: "vieja"),
            BillResponseElement(id: 0034, date: "2018-05-11T22:49:24.000Z", amount: -80.0, fee: nil, billDescription: nil),
            BillResponseElement(id: 0894, date: "000-04-11T22:49:24.000Z", amount: -80.0, fee: -10.0, billDescription: "prueba"),
            BillResponseElement(id: 1234, date: "2020-02-11T22:49:24.000Z", amount: 110.0, fee: -10.0, billDescription: "2020")
        ]
        
        billVM = BillViewModel.mapperToBillResponse(response: MockInteratorArray)
        
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    // MARK: - Tests ViewModel
    
    func testViewModelReturnNill()
    {
        let billResponseNill:BillResponse = BillResponse()
        billVM = BillViewModel.mapperToBillResponse(response: billResponseNill)
        XCTAssertEqual(billVM.billResponse.count, 0)
    }
    
    // se revisa total de suma
    func testViewModelReturnAllElementsArrayResponse()
    {
        let arrayFirst = billVM.billResponse.first
        let arrayTwo = billVM.billResponse[1]
        let arrayThree = billVM.billResponse[2]
        
        XCTAssertEqual(arrayFirst?.getTotalValue() , 100.0 )
        XCTAssertEqual(arrayTwo.getTotalValue() , -120.0 )
        XCTAssertEqual(arrayThree.getTotalValue() , -80.0 )
        XCTAssertEqual(arrayFirst?.getTypeAmount().rawValue , "Positive" )
        XCTAssertEqual(arrayTwo.getTypeAmount().rawValue , "Negative" )
        XCTAssertEqual(billVM.billResponse.count,MockInteratorArray.count)
    }
    
      // se revisa validacion por formato de fecha
    func testViewModelReturnAllElementsArrayValide()
    {
        let arrayError = billVM.billResponse[3]
        XCTAssertEqual(arrayError.isValideFormatterDate().rawValue, "null")
        XCTAssertEqual(billVM.billValide.count,(MockInteratorArray.count - 1))
    }
    
      // se revisa el ordendo del arreglo
    func testViewModelReturnAllElementsArraySort()
    {
        XCTAssertEqual(billVM.billSorted.first?.date,"2020-02-11T22:49:24.000Z")
        
    }
    
    // se revisa el depurada gastos con el mismo id
    func testViewModelReturnAllElementsArrayDepurate()
    {
        let array = billVM.billDepurate.filter({ $0.id == 1234 } )
        print(array)
        XCTAssertTrue(array.count == 1)
        XCTAssertEqual(array.first?.date, "2020-02-11T22:49:24.000Z")
    }
    
}
