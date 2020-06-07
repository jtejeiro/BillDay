

import UIKit
import Alamofire

class BaseAPIClient {

    private var baseURLAPI : URL {

        if let url = URL(string: Kconstants.KbaseUrl) {
               return url
           }else {
               return URL(string: "")!
           }
       }

    
    func getAPIRequest(relativePath: String , parameters:[ String : Any] ) -> DataRequest{
        let urlAbsolute = baseURLAPI.appendingPathComponent(relativePath)
        var parametersAbsolute:[ String : Any] = [:]
        
        if parameters.count > 0 {
            for key in parameters {
                parametersAbsolute[key.key] = key.value
            }
        }
        
        return AF.request(urlAbsolute, method: .get, parameters: parametersAbsolute , encoding: URLEncoding.default)
    }
    
}

