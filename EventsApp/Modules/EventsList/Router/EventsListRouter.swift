//
//  EventsListRouter.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import UIKit

class EventsListRouter: BaseCoordinator {
    

    enum Destination {
        case detailsViewController(dependancy: EventModel)
    }
    
    var rootViewController: UIViewController
    
    init(rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .detailsViewController( let model):
            return DetailsBuilder().instantiate(model: model)
        }
    }
    func navigate(to destination: EventsListRouter.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.show(viewController, sender: rootViewController)
    }
    
    func present(to destination: EventsListRouter.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.present(viewController, animated: true)
    }
    
    
}

