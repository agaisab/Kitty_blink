//
//  ImageURL.swift
//  Kitty_blink
//
//  Created by Ł.B Morapel on 15/11/2021.
//

import UIKit

extension UIImageView {
    func loadIMG (url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
