//
//  AlamofireProvider.swift
//  Movies24i
//
//  Created by Yasir M Turk on 18/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MCoreKit
import Alamofire

open class AlamofireProvider<Target: NetworkEndpoint>: NetworkService {

    public var config: URLSessionConfiguration? {
        didSet {
            if let config = config {
                manager = SessionManager(configuration: config)
            }
        }
    }

    public var manager: SessionManager

    public init(_ config: URLSessionConfiguration? = nil) {
        let config = config ?? URLSessionConfiguration.default
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        self.manager = SessionManager(configuration: config)
    }

    public init(manager: SessionManager) {
        self.config = manager.session.configuration
        self.manager = manager
    }

    public func fetch(_ target: Target, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask? {
        guard let url = target.endPoint else {
            return nil
        }

        let method: HTTPMethod = HTTPMethod(rawValue: target.httpMethod) ?? .get
        let encoding: ParameterEncoding = target.encoding == .url ? URLEncoding.default : JSONEncoding.default
        let request = manager.request(url, method: method, parameters: target.parameters, encoding: encoding, headers: target.headers)
            .validate()
            .responseData { completion($0.data, $0.error) }
        return request.task
        //                switch response.result {
        //                case .success(let data):
        //                    completion(data, nil)
        //                case .failure(let error):
        //                    completion(response.data, error)
        //                }
    }

}
