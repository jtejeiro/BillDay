
import Foundation


// MARK: - View Protocol
protocol BillView: class {
    
    var presenter: BillPresenter? { get set }
    func showBill(billVM:BillViewModel)
    func showAlertError(title:String,message:String)
    
}

// MARK: - Presenter
protocol BillPresenter: class {
    
    var view: BillView? { get set }
    var interactor: BillInteractor? { get set }
    var router: BillRouter? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    
    func userClickGoBack()
}


// MARK: - Interactor
protocol BillInteractorCallback: class {
    func fetchedBill(result: Result< [BillResponseElement], Error>)
}

protocol BillInteractor: class {
    
    var presenter: BillInteractorCallback? { get set }
    func fetchBill()
    
}

// MARK: - Router
protocol BillRouter: class {
    func goBack()
}
