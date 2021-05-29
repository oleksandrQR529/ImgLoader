//
//  UIStoryboard+Extensions.swift
//  ImgLoader
//
//  Created by Саша Дранчук on 29.05.2021.
//

import Foundation
import UIKit

extension UIStoryboard {
    
    static func getViewController(storyboard: String, identifier: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        return sb.instantiateViewController(withIdentifier: identifier)
    }
}
