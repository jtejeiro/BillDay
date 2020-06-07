
import Foundation



class BillPresenterImpl{
    
    
    // MARK: - Properties
    weak var view: BillView?
    var interactor: BillInteractor?
    var router: BillRouter?
    
    // MARK: - Var
    var billVM : BillViewModel!
    
    // MARK: - Init
    init() {
    }
    
}

// MARK: - BillPresenter methods
extension BillPresenterImpl: BillPresenter {
    
    func viewDidLoad() {
        self.interactor?.fetchBill()
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
        //
    }
    
    func userClickGoBack() {
        router?.goBack()
    }
}
// MARK: - BillInteractorCallback methods
extension BillPresenterImpl: BillInteractorCallback {
    
    func fetchedBill(result: Result< [BillResponseElement], Error>) {
        
        switch result {
          case .success(let data):
               let listResponse:BillResponse = data
               self.billVM = BillViewModel.mapperToBillResponse(response: listResponse)
               view?.showBill(billVM: self.billVM)
          case .failure(let error):
              print(error)
              view?.showAlertError(title: "Error", message: "check connection")
          }
    }
    
    

}


// MARK: - Private methods
private extension BillPresenterImpl {
    
  
}
