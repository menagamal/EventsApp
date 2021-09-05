//
//  EventsBuilder.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import UIKit
class EventsBuilder {
    func instantiate(id: String, navigationController: UINavigationController) -> EventsListViewController {
        let viewController: EventsListViewController = UIViewController.instanceXib()
        let router = EventsListRouter(rootViewController: navigationController)
        let viewModel = EventsViewModel(router: router, network: NetworkManager(), id: id)
        viewController.viewModel = viewModel
        return viewController
    }
}
