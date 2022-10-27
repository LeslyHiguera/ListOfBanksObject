//
//  CustomTableViewCell.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var bankImage: UIImageView!
    
    var bank: Bank? {
        didSet {
            setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setup() {
        nameLabel.text = bank?.bankName
        descriptionLabel.text = bank?.description
        if let url = bank?.url {
            bankImage.downloaded(from: url, placeHolder: nil)
        }
        
    }
    
}
