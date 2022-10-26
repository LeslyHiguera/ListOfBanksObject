//
//  Bank.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation

struct Bank: Decodable {
    let bankName: String?
    let url: String?
    let age: Int?
    let description: String?
    
    init(bankName: String?, url: String?, age: Int?, description: String?) {
        self.bankName = bankName
        self.url = url
        self.age = age
        self.description = description
    }
}
