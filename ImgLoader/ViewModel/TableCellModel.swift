//
//  TableCellModel.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 27.05.2021.
//

import Foundation
import UIKit

class TableCellModel: NSObject {

    private(set) var nameImage: String?
    private(set) var image: UIImage?
    private(set) var imageLoadProgress: Double?
    private(set) var request: URLSessionDataTask?
    private (set) var observation: NSKeyValueObservation?
    
    init(nameImage: String?, image: UIImage?, loadProgress progress: Double?, loadRequest request: URLSessionDataTask?) {
        self.nameImage = nameImage
        self.image = image
        self.imageLoadProgress = progress
        self.request = request
    }
    
    func setImage(image: UIImage?) {
        self.image = image
    }
    
    func setLoadProgress(progress: Double?) {
        self.imageLoadProgress = progress
    }
    
    func setRequest(request: URLSessionDataTask?) {
        self.request = request
    }
    
    func setObservation(observation: NSKeyValueObservation?) {
        self.observation = observation
    }
    
}
