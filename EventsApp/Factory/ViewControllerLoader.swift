//
//  ViewControllerLoader.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

// MARK: Factory 
import Foundation
import UIKit

protocol ViewControllerFactory {
    func createViewController( with category: ViewControllerCategory) -> UIViewController
}

enum ViewControllerCategory {
    case CategoryOne, CategoryTwo, CategoryThird
}

class ViewControllerLoader: ViewControllerFactory {
    
    private var loadedViewControllers = [ViewControllerCategory: UIViewController]()
    
    func createViewController(with category: ViewControllerCategory) -> UIViewController {
        if let vc = loadedViewControllers[category] {
            return vc
        }
        let vc = UIViewController()
        loadedViewControllers[category] = vc
        return vc
    }
}
