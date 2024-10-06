//
//  UIImageView+Extension.swift
//  Telstra POC
//
//  Created by Rajat Kumar on 06/10/24.
//

import UIKit

extension UIImageView {
  func loadImage(at url: URL) {
    UIImageLoader.loader.load(url, for: self)
  }

  func cancelImageLoad() {
    UIImageLoader.loader.cancel(for: self)
  }
}
