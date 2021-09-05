//
//  EventsBuilder.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import UIKit
class EventsBuilder {
    func instantiate(id: String) -> EventsListViewController {
        let viewController: EventsListViewController = UIViewController.instanceXib()
        let router = EventsListRouter(rootViewController: viewController)
        let viewModel = EventsViewModel(router: router, network: NetworkManager(), id: id)
        viewController.viewModel = viewModel
        return viewController
    }
}
