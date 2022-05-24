//
//  ServiceLayer.swift
//  TestAppBeon
//
//  Created by Gabriel Marson on 24/05/22.
//

import Foundation

protocol ServiceLayerContract: AnyObject {
    func getNumber(number: Int, handler: @escaping (Result<String, CustomError>) -> ())
}

enum CustomError: Error {
    
    case badUrl
    
    case unexpected
    
    case decoding
}

class ServiceLayer: ServiceLayerContract {
    
    private let enpoint: String = "http://numbersapi.com/"
    
    func getNumber(number: Int, handler: @escaping (Result<String, CustomError>) -> ()) {
        
        guard let url = URL(string: "\(enpoint)\(number)") else {
            handler(.failure(.badUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                handler(.failure(.unexpected))
                return
            }
            
            guard let message = String(data: data, encoding: .utf8) else {
                handler(.failure(.decoding))
                return
            }
            
            handler(.success(message))
        }

        task.resume()
        
    }
    
}
