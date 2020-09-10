//
//  PictureCollectionViewCell.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 10/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var pictureTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureWithPicture(picture: Picture) {
        pictureTitleLabel.text = picture.title
        loadImage(url: picture.url)
    }

    private func loadImage(url: String) {
        imageView.image = nil
        let _ = ImageLoader.shared.loadImage(url) { (result) in
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
