//
//  ImageTableViewCell.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    static let identifier = "contentCell"
    
    @IBOutlet weak var img: UIImageView?
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var progresLbl: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var imageName: UILabel!
    
    weak var cellModel: TableCellModel?
    
    var loadImageTapped: (() -> ())?
    
    private var request: URLSessionDataTask?
        
    func config(model: TableCellModel) {
        imageName.text = model.nameImage
        cellModel = model
        img?.image = model.image
        request = model.request
        if let progress = model.imageLoadProgress {
            progresLbl.text = "\(Int(progress * 100))%"
            progressView.setProgress(Float(progress), animated: false)
        }
    }
    
    func checkStatusOfElements() {
        var elementIsHidden = true
        cellModel?.image == nil ? (elementIsHidden = false) : ()
        self.progresLbl.isHidden = elementIsHidden
        self.progressView.isHidden = elementIsHidden
        self.loadBtn.isHidden = elementIsHidden
    }
    
    @IBAction func loadBtnTapped(_ sender: Any) {
        
        if self.request == nil {            
            self.loadImageTapped?()
        }
        else {
            self.request?.cancel()
            self.request = nil
            self.cellModel?.setRequest(request: nil)
            self.cellModel?.setLoadProgress(progress: 0.0)
            if let model = self.cellModel {
                self.config(model: model)
            }
        }
    }
    
}
