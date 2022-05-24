//
//  SearchViewModel.swift
//  TestAppBeon
//
//  Created by Gabriel Marson on 24/05/22.
//

import Foundation
import Combine

class SearchViewModel {
    
    private var service: ServiceLayerContract
    
    @Published
    private(set) var state: State = .idle
    
    enum State {
        case idle
        case error
        case success(String)
    }
    
    init(service: ServiceLayerContract = ServiceLayer()) {
        self.service = service
    }
    
    func getNumber(number: String) {
        guard let casted = Int(number) else {
            state = .error
            return
        }
        
        service.getNumber(number: casted) { [weak self] result in
            switch result {
            
            case .success(let message):
                self?.state = .success(message)
            case .failure(_):
                self?.state = .error
            }
        }
        
    }
    
}
