//
//  ViewControllerLoader.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

// MARK: Factory 
import Foundation
import UIKit

protocol BaseCoordinator {
    associatedtype Destination
    var rootViewController: UIViewController { get set }
    func makeViewController(for destination: Destination) -> UIViewController
}


class TabbedRouter: BaseCoordinator {
    
    private var loadedViewControllers = [String: UIViewController]()

    enum Destination {
        case eventsViewController(id: String)
    }
    
    var rootViewController: UIViewController
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .eventsViewController(let id ):
            return loadEvents(with: id)
        }
    }
    func navigate(to destination: TabbedRouter.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.show(viewController, sender: rootViewController)
    }
    
    func present(to destination: TabbedRouter.Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.present(viewController, animated: true)
    }
    
    func loadEvents(with id: String)  -> UIViewController {
        guard let navigationController = rootViewController.navigationController else {
            return UIViewController() 
        }
        if let vc = loadedViewControllers[id] {
            return vc
        }
        let vc = EventsBuilder().instantiate(id: id, navigationController: navigationController)
        loadedViewControllers[id] = vc
        return vc
    }
}
