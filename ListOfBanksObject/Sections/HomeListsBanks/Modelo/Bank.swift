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
}
