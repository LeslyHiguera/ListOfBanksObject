//
//  BanksRepository.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation
import UIKit
import CoreData

protocol BanksRepositoryProtocol {
    func getBanks(completionHandler: @escaping (Result<[Bank], Error>) -> Void)
}

class BanksRepository: BanksRepositoryProtocol {
    
    func getBanks(completionHandler: @escaping (Result<[Bank], Error>) -> Void) {
        let localBanks = self.getBanks()
        if localBanks.count > 0 {
            completionHandler(.success(localBanks))
            return
        }
        let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/banks")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let banks = try? JSONDecoder().decode([Bank].self, from: data) {
                DispatchQueue.main.async {
                    self.deleteAllBanks()
                    self.saveBanks(banks)
                    completionHandler(.success(banks))
                }
                
            }
        })
        task.resume()
    }
    
    func saveBanks(_ banks: [Bank]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        banks.forEach { bank in
            let bankCoreData = BanksCD(context: appDelegate.persistentContainer.viewContext)
            bankCoreData.bankName = bank.bankName
            bankCoreData.age = Int64(bank.age ?? 0)
            bankCoreData.descript = bank.description
            bankCoreData.url = bank.url
            appDelegate.saveContext()
        }
    }
    
    private func getBanks() -> [Bank] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var banks: [Bank] = []
        do {
            let fetchRequest: NSFetchRequest<BanksCD> = BanksCD.fetchRequest()
            let coreDataBanks = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            coreDataBanks.forEach {
                let back = Bank(bankName: $0.bankName,
                                url: $0.url,
                                age: Int($0.age),
                                description: $0.descript)
                banks.append(back)
            }
        } catch {
            print(error.localizedDescription)
        }
        return banks
    }
    
    private func deleteAllBanks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        do {
            let fetchRequest: NSFetchRequest<BanksCD> = BanksCD.fetchRequest()
            let CoreDataCourses = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            CoreDataCourses.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
}
