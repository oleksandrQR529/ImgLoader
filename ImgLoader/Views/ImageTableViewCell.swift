//
//  ImageTableViewCell.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import UIKit
import Alamofire

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "contentCell"
    
    @IBOutlet weak var img: UIImageView?
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var progresLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageName: UILabel!
    
    weak var cellModel: TableCellModel?
    
    var loadImageTapped: (() -> (DataRequest?))?
    
    private var request: DataRequest?
        
    func config(model: TableCellModel) {
        self.imageName.text = model.nameImage
        self.cellModel = model
        self.img?.image = model.image
    }
    
    func checkStatusOfElements() {
        var elementIsHidden = true
        if cellModel?.image == nil {
            progressView.setProgress(0, animated: false)
            progresLbl.text = "0%"
            elementIsHidden = false
        }
        self.progresLbl.isHidden = elementIsHidden
        self.progressView.isHidden = elementIsHidden
        self.loadBtn.isHidden = elementIsHidden
    }
    
    @IBAction func loadBtnTapped(_ sender: Any) {
        
        if request == nil {
            self.request = loadImageTapped?()
        }
        else if !(request?.isCancelled ?? true) {
            request?.cancel()
            self.request = nil
        }
    }
    
}
