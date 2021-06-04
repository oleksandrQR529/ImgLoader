//
//  ViewController.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 25.05.2021.
//

import UIKit

class StartView: UIViewController {
    
    @IBOutlet weak var imgTable: UITableView!

    private let model = StartViewModel()
            
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
            
            DispatchQueue.global(qos: .utility).async {
                cell.loadImageTapped = { [weak self] in
                    DataModel.shared.loadImage(imageUrl: self?.model.getUrlImage(at: indexPath.row) ?? "") { [weak self] image in
                        self?.model.tableCellModels[indexPath.row].setImage(image: image)
                        DispatchQueue.main.async {
                            cell.checkStatusOfElements()
                            self?.imgTable.reloadData()
                        }
                    } onStarted: { [weak self] request in
                        self?.model.tableCellModels[indexPath.row].setRequest(request: request)
                        DispatchQueue.main.async {
                            self?.imgTable.reloadData()
                        }
                        self?.model.tableCellModels[indexPath.row].setObservation(observation:
                            request.progress.observe(\.fractionCompleted) { [weak self] progress, _ in
                                self?.model.tableCellModels[indexPath.row].setLoadProgress(progress: progress.fractionCompleted)
                                DispatchQueue.main.async {
                                    if let cell = self?.imgTable.cellForRow(at: indexPath) as? ImageTableViewCell {
                                        cell.progresLbl.text = "\(Int(progress.fractionCompleted * 100))%"
                                        cell.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                                    }
                                }
                            })
                    }
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

