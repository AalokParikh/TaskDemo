//
//  NetworkManager.swift
//  DataFetchOptimised
//
//  Created by Aalok Parikh on 03/05/24.
//

import Foundation
import Alamofire

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private override init() {}
    func makeAPICall(urlString: String, parameters: [String: Any] = [:], headers: HTTPHeaders = HTTPHeaders(), method: String = "GET", encoding: ParameterEncoding = JSONEncoding.default, completion:@escaping (PostObject?) -> Void) {
        AF.request(urlString, parameters: parameters).response { response in
            switch response.result {
                case .success(let data):
                    do {
                        completion(try PostObject(data: data!))
                    } catch {
                        print("Error while decoding response: \"\(error)\" from: \(String(describing: String(data: data ?? Data(), encoding: .utf8)))")
                    }
                case .failure(let error):
                    print("Error in request as request failure is \(error)")
                    completion(nil)
            }
        }
    }
}
