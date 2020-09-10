//
//  ViewController.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StoryboardInstantiable {

    enum Section {
        case main
    }
    typealias PictureDataSource = UICollectionViewDiffableDataSource<Section, Picture>
    typealias PictureSnapshot = NSDiffableDataSourceSnapshot<Section, Picture>
    private lazy var datasource = makeDataSource()

    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: HomeViewModel!
    var coordinator: HomeCoordinator!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
        fetchPictures()
    }

    func fetchPictures() {
        viewModel.fetchPictures {[weak self] (result) in
            switch result {
            case .success:
                self?.applySnapshot()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func configureView() {
        self.title = viewModel.title
    }

    private func configureCollectionView() {
        let nib = UINib(nibName: "PictureCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PictureCell")
    }

    func makeDataSource() -> PictureDataSource {
        return PictureDataSource(collectionView: collectionView) { (collectionView, indexPath, picture) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCollectionViewCell
            cell?.configureWithPicture(picture: picture)
            return cell
        }
    }

    func applySnapshot() {
        var snapshot = PictureSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.pictures, toSection: .main)
        datasource.apply(snapshot)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let safeAreaInsets = self.view.safeAreaInsets
        return CGSize(width: self.view.frame.width - (safeAreaInsets.left + safeAreaInsets.right), height: self.view.frame.height - (safeAreaInsets.top + safeAreaInsets.bottom))
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator.navigateDetail(with: viewModel.pictures[indexPath.item])
    }
}

