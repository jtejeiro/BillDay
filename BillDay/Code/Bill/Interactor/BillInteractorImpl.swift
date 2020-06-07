
import Foundation


class BillInteractorImpl {
    
    // MARK: - Properties
    weak var presenter: BillInteractorCallback?
    
    // MARK: - Repository
   let service: BaseAPIClient
    
    // MARK: - Var
    
    init (service:BaseAPIClient) {
        self.service = service
    }
}

extension BillInteractorImpl: BillInteractor {
    
    // MARK: - fetch BillInteractorImpl
    func fetchBill(){
        fetchBillApiClient()
    }
    
    
    // MARK: - fetch BillInteractorImpl ApiCliente
    
    func fetchBillApiClient() {
        let absolutePath = "transactions.json"
        
        service.getAPIRequest(relativePath: absolutePath , parameters: [:]).response{ (response) in
            debugPrint(response)
            
            switch response.result {
            case .success:
                
                guard let data = response.data else {return}
                if let result = try? JSONDecoder().decode( BillResponse.self, from: data){
                    let BillList:BillResponse = result
                    self.presenter?.fetchedBill(result: .success(BillList))
                }
            case let .failure(error):
                print(error)
                self.presenter?.fetchedBill(result: .failure(error))
            }
        }
    }
    
    
    
}
