//
//  LoadFileHelper.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation
@testable import AstronomyPictures

class LoadFileHelper {

    static func loadDataFromFile(with name: String) -> Data? {
        guard let path = Bundle(identifier: "com.bonsebas.AstronomyPicturesTests")?.path(forResource: name, ofType: "json") else {
            return nil
        }

        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }

    static func loadObjectFromFile<T>(_ object: T.Type, fileName: String) -> T where T: Decodable {
        guard let data = LoadFileHelper.loadDataFromFile(with: fileName) else { fatalError("File doesn't exist") }

        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        } catch let error {
            print(error.localizedDescription)
            fatalError("Parsing error")
        }
    }
}
