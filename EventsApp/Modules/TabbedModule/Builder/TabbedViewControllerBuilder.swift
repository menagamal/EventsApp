//
//  TabbedViewControllerBuilder.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation



class TabbedViewControllerBuilder {
    func instantiate(viewController: ViewController){
        let router = TabbedRouter(rootViewController: viewController)
        viewController.viewModel = SegmentViewModel(router: router, network: NetworkManager())
    }
}
