

import Foundation
import UIKit

class BaseConfigurator {

    var viewController: UIViewController {
        return createViewController()
    }
    
    
    private func createViewController() -> UIViewController {
        let view = BillConfigurator.createModule()
    return view
    }
    
    static func ConfigGlobalApareance(){
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.9411764706, green: 0.3960784314, blue: 0.02745098039, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }

    
}
