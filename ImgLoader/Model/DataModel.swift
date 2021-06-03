//
//  DataModel.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import Foundation
import UIKit

final class DataModel {
    static let shared = DataModel()
    
    static let images: [Image] = loadData("ImagesData.json")
    
    func loadImage(imageUrl url: String, onSuccess: @escaping (UIImage?) -> Void, onStarted: @escaping (URLSessionDataTask) -> Void) {
        
        guard let url = URL(string: url) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.global(qos: .utility).async {
                if let err = error {
                    print("Failed to get data from url:", err)
                }

                guard let data = data, let image = UIImage(data: data) else { return }
                onSuccess(image)
            }
        }
        onStarted(task)
        task.resume()
    }
    
}

func loadData<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
    
}
