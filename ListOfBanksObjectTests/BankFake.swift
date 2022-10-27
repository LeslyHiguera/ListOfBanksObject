//
//  BankFake.swift
//  ListOfBanksObjectTests
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation
@testable import ListOfBanksObject

enum BankFake {
    
    static var values: [Bank] {
        [.init(bankName: "Paga todo",
               url: "",
               age: 5,
               description: "Banco paga todo")]
    }

}
