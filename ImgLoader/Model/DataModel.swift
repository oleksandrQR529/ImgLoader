//
//  DataModel.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import Foundation
import UIKit
import Alamofire

final class DataModel {
    static let shared = DataModel()
    
    static let images: [Image] = loadData("ImagesData.json")
    
    func loadImage(imageUrl url: String, onSuccess: @escaping (UIImage?) -> Void, onLoading: @escaping (Double) -> Void, onStarted: @escaping (DataRequest) -> Void){
        
        let request = AF.request(url)
        onStarted(request)
        DispatchQueue.main.async {
            request
                .downloadProgress(closure: { progress in
                    onLoading(progress.fractionCompleted)
                })
                .response { response in
                guard let data = response.data, let image = UIImage(data: data) else { return }
                    if request.isCancelled {
                        onSuccess(nil)
                    }
                    else if request.isFinished {
                        onSuccess(image)
                    }
                }
        }
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
