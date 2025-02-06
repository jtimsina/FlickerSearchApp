//
//  APIManager.swift
//  FlickerSearch
//
//  Created by Jai Timsina on 2/6/25.
//

import Combine
import Foundation

protocol APIManagerContract {
    func getDataFromNetworkLayer<T:Decodable>(url:URL, modelType:T.Type) -> AnyPublisher<T,Error>
}

struct APIManager {
    private let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}


extension APIManager: APIManagerContract {
    func getDataFromNetworkLayer<T>(url: URL, modelType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        
        return URLSession.shared.dataTaskPublisher(for: url)
                    .map{$0.data}
                    .decode(type: modelType.self, decoder: JSONDecoder())
                    .eraseToAnyPublisher()
    }
    
    
}
