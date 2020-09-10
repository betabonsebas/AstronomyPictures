//
//  HomeViewModel.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

class HomeViewModel: ViewModel {
    private let dispatchGroup = DispatchGroup()
    var pictures: [Picture]
    var title: String
    var service: Service


    init(service: Service = PictureService()) {
        title = "Home"
        self.service = service
        self.pictures = []
    }

    func fetchPictures(completion: @escaping (Result<Bool, Error>) -> Void) {
        pictures.removeAll()
        let calendar = Calendar.current
        let lastPictureDate = Date()

        for index in 0...7 {
            dispatchGroup.enter()
            guard let nextPictureDate = calendar.date(byAdding: .day, value: -index, to: lastPictureDate) else {
                continue
            }

            service.fetch(for: nextPictureDate.dashedYYYYMMddString()) { [weak self] (result: Result<Picture, Error>) in
                switch result {
                case .success(let picture):
                    self?.pictures.append(picture)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            self.pictures.sort { (picture1, picture2) -> Bool in
                guard let date1 = picture1.date.date(), let date2 = picture2.date.date() else {
                    return false
                }
                return date1 > date2
            }

            completion(.success(true))
        }
    }
}
