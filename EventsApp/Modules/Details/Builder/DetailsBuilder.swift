//
//  DetailsBuilder.swift
//  EventsApp
//
//  Created by Mena Gamal on 06/09/2021.
//

import Foundation
import UIKit
class DetailsBuilder {
    func instantiate(model:EventModel) -> DetailsViewController {
        let viewController: DetailsViewController = UIViewController.instanceXib()
        let viewModel = DetailsViewModel(model: model)
        viewController.viewModel = viewModel
        return viewController
    }
}
