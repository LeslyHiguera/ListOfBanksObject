//
//  BanksRepositoryMock.swift
//  ListOfBanksObjectTests
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation
@testable import ListOfBanksObject

class BanksRepositoryMock: BanksRepositoryProtocol {
    
    var banks: [Bank]?
    
    func getBanks(completionHandler: @escaping (Result<[Bank], Error>) -> Void) {
        if let banks = banks {
            completionHandler(.success(banks))
        }
    }
    
}
