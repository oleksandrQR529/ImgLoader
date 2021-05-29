//
//  ViewController.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import UIKit
import Alamofire

class StartView: UIViewController {
    
    @IBOutlet weak var imgTable: UITableView!

    private let model = StartViewModel()
    
    private var request: DataRequest?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        model.setTableCellModels()
    }
    
    private func configTableView() {
        imgTable.dataSource = self
        imgTable.delegate = self
    }
    
}

extension StartView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.getNumberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell {
            cell.config(model: model.tableCellModels[indexPath.row])

            DispatchQueue.main.async {
                cell.loadImageTapped = { [ weak self]  in
                    DataModel.shared.loadImage(imageUrl: self?.model.getUrlImage(at: indexPath.row) ?? "") { [weak self] image in
                        self?.imgTable.beginUpdates()
                        cell.img?.image = image
                        self?.model.tableCellModels[indexPath.row].setImage(image: image)
                        cell.checkStatusOfElements()
                        self?.imgTable.endUpdates()
                    } onLoading: { [weak self] progress in
                        self?.imgTable.beginUpdates()
                        cell.progressView.setProgress(Float(progress), animated: true)
                        cell.progresLbl.text = "\(Int(progress * 100))%"
                        self?.imgTable.endUpdates()
                    } onStarted: { request in
                        self?.request = request
                    }
                    return self!.request
                }
            }
            cell.checkStatusOfElements()
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let image = model.tableCellModels[indexPath.row].image else { return }
        if let vc = UIStoryboard.getViewController(storyboard: "Main", identifier: "ImageDetailViewController") as? ImageDetailViewController {
            vc.image = image
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

