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
    
    init(nameImage:String?, image:UIImage?) {
        self.nameImage = nameImage
        self.image = image
    }
    
    func setImage(image: UIImage?) {
        self.image = image
    }
    
}
