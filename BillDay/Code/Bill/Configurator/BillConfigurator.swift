
import UIKit
import Foundation

@objc final class BillConfigurator: NSObject {
    
    @objc class func createModule() -> UIViewController {
        
        let apiClient = BaseAPIClient()
        let view = BillViewController()
        let presenter: BillPresenterImpl = BillPresenterImpl()
        
        let interactor = BillInteractorImpl(service: apiClient)
        
        let router: BillRouterImpl =  BillRouterImpl(mainRouter: view)
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
}
