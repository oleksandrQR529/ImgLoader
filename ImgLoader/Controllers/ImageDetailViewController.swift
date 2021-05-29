//
//  ImageDetailViewController.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 27.05.2021.
//

import UIKit

class ImageDetailViewController: UIViewController {
        
    @IBOutlet weak var imageView: UIImageView?
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView?.image = image
    }

}
