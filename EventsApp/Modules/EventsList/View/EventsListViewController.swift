//
//  EventsListViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import UIKit
import RxCocoa
import RxSwift
class EventsListViewController: UIViewController {

    @IBOutlet weak var eventsTableView: UITableView!

    private let disposeBag = DisposeBag()
    
    var viewModel: EventsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchEvents()
    }
    
    private func setupTableView() {
        
    }
}
