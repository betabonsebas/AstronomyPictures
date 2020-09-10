//
//  DetailViewController.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, StoryboardInstantiable {

    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var explanationLabel: UILabel!
    @IBOutlet private weak var descriptionView: UIView!
    @IBOutlet private weak var pictureImageView: UIImageView!

    var viewModel: DetailViewModel!
    var coordinator: DetailCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0

        configureUI()
        configureGestureRecognizer()
    }

    private func configureUI() {
        title = viewModel.title
        dateLabel.text = viewModel.picture.date
        explanationLabel.text = viewModel.picture.explanation
        loadImage()
    }

    private func configureGestureRecognizer() {
        let zoomRecognizer = UITapGestureRecognizer(target: self, action: #selector(zoomHandler(_:)))
        zoomRecognizer.numberOfTapsRequired = 2
        pictureImageView.addGestureRecognizer(zoomRecognizer)

        let showDescriptionRecognizer = UITapGestureRecognizer(target: self, action: #selector(showViewHandler(_:)))
        showDescriptionRecognizer.numberOfTapsRequired = 1
        showDescriptionRecognizer.require(toFail: zoomRecognizer)

        pictureImageView.addGestureRecognizer(showDescriptionRecognizer)
    }

    @objc private func showViewHandler(_ recognizer: UIGestureRecognizer) {
        UIView.animate(withDuration: 1.0) {
            self.descriptionView.isHidden = !self.descriptionView.isHidden
        }
    }

    @objc private func zoomHandler(_ recognizer: UIGestureRecognizer) {
        if (scrollView.zoomScale == scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }

    private func loadImage() {
        let _ = ImageLoader.shared.loadImage(viewModel.picture.hdurl) { result in
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    self.pictureImageView.image = image
                }
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }

    private func configureImageView(for image: UIImage) {

    }
}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pictureImageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if (scrollView.zoomScale > 1) {
            if let image = pictureImageView.image {
                let widthRatio = pictureImageView.frame.width / image.size.width
                let heightRatio = pictureImageView.frame.height / image.size.height

                let zoomRatio = widthRatio < heightRatio ? widthRatio : heightRatio
                let newWidth = image.size.width * zoomRatio
                let newHeight = image.size.height * zoomRatio
                let horizontalCondition = newWidth * scrollView.zoomScale > pictureImageView.frame.width
                let left = 0.5 * (horizontalCondition ? newWidth - pictureImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let verticalCondition = newHeight*scrollView.zoomScale > pictureImageView.frame.height

                let top = 0.5 * (verticalCondition ? newHeight - pictureImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))

                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        }else {
            scrollView.contentInset = .zero
        }
    }
}
