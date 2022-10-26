//
//  ViewController.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Private Properties
    
    private var viewModel = BanksViewModel()
    
    // MARK: - Life cycle View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(.init(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        viewModel.getBanks()
        viewModel.success = {
            self.tableView.reloadData()
        }
        viewModel.error = { error in
            print(error)
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = viewModel.banks[indexPath.row].bankName
        return cell
    }
    
}
