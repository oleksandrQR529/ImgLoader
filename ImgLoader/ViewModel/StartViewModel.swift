//
//  StartViewModel.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 27.05.2021.
//

import Foundation
import UIKit

class StartViewModel {

    private(set) var tableCellModels: [TableCellModel] = []
    
    func setTableCellModels() {
        tableCellModels = []
        for image in DataModel.images {
            let cellModel = TableCellModel(nameImage: image.name, image: nil, loadProgress: 0.0, loadRequest: nil)
            tableCellModels.append(cellModel)
        }
    }
    
    func getNumberOfItems() -> Int {
        return tableCellModels.count
    }
    
    func getUrlImage(at index:Int) -> String {
        return DataModel.images[index].url
    }
    
}
