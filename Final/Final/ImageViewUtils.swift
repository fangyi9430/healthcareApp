//
//  ImageViewUtils.swift
//  Final
//
//  Created by 李方一 on 12/8/24.
//

import UIKit
import Foundation


extension UIImageView {
    func loadRemoteImage(from url: URL) {
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
