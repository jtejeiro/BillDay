
import UIKit
import Foundation


class BillRouterImpl {
    
    var mainRouter:UIViewController
    
    init(mainRouter: UIViewController) {
        self.mainRouter = mainRouter
    }
}
 // MARK: - BillRouterImpl
extension BillRouterImpl: BillRouter  {
    
    func goBack() {
           mainRouter.navigationController?.popViewController(animated: true)
       }
}
