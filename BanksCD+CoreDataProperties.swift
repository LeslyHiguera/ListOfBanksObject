//
//  BanksCD+CoreDataProperties.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//
//

import Foundation
import CoreData


extension BanksCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BanksCD> {
        return NSFetchRequest<BanksCD>(entityName: "BanksCD")
    }

    @NSManaged public var bankName: String?
    @NSManaged public var url: String?
    @NSManaged public var descript: String?
    @NSManaged public var age: Int64

}

extension BanksCD : Identifiable {

}
