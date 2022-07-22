//
//  APILoader.swift
//  TV Guide
//
//  Created by Thalisson da Rosa on 27/05/22.
//

import Foundation

typealias APIHandler = RequestHandler & ResponseHandler
class APILoader<T: APIHandler> {
    private let apiRequest: T
    private let urlSession: NetworkSession

    init(apiRequest: T, urlSession: NetworkSession = URLSession.shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }

    func request(router: Router, completion: @escaping (Result<T.ResponseDataType, Error>) -> ()) {
        do {
            let urlRequest = try apiRequest.makeRequest(from: router)
            urlSession.loadData(with: urlRequest) { data, response, error in
                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }
                do {
                    let parsedResponse = try self.apiRequest.parseResponse(data: data)
                    DispatchQueue.main.async {
                        completion(.success(parsedResponse))
                    }
                } catch {
                    completion(.failure(APIError.invalidData))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
