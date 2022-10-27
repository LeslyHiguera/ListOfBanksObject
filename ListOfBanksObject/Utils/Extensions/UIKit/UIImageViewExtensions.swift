//
//  UIImageViewExtensions.swift
//  ListOfBanksObject
//
//  Created by Lesly Higuera on 26/10/22.
//

import UIKit

extension UIImageView {

    func downloaded(from urlString: String?,
                    placeHolder: UIImage?,
                    contentMode mode: ContentMode = .scaleAspectFit) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            self.image = placeHolder
            return
        }
        downloaded(from: url, placeHolder: placeHolder, contentMode: mode)
    }

    func downloaded(from url: URL,
                    placeHolder: UIImage?,
                    contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        ImageService.image(for: url) { image   in
            self.image = image ?? placeHolder
        }
    }

}
