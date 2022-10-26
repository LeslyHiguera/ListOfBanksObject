//
//  BanksRepository.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import Foundation

class BanksRepository {
    
    func getBanks(completionHandler: @escaping (Result<[Bank], Error>) -> Void) {
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
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data,
               let banks = try? JSONDecoder().decode([Bank].self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(banks))
                }
                
            }
        })
        task.resume()
    }
    
}
