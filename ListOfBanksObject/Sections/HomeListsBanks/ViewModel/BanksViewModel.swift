//
//  BanksViewModel.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation

class BanksViewModel {
    
    //MARK: - Internal Properties
    var error: (String) -> Void = { _ in }
    var success: () -> Void = { }
    var loading: (Bool) -> Void = { _ in }
    var banks: [Bank] = []
    
    //MARK: - Private Properties
    
    private var repository: BanksRepositoryProtocol
    
    init(repository: BanksRepositoryProtocol) {
        self.repository = repository
    }
    
    func getBanks() {
        loading(true)
        repository.getBanks { [weak self] result in
            self?.loading(false)
            switch result {
            case .success(let banks):
                self?.banks = banks
                self?.success()
            case .failure(let error):
                self?.error(error.localizedDescription)
            }
        }
    }
    
}
    
