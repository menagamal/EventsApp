//
//  EventsListViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import UIKit
import RxCocoa
import RxSwift
class EventsListViewController: BaseViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: EventsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        BindUI()
        viewModel?.fetchEvents()
    }
    
    private func registerTable() {
        eventsTableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
    }
    
    private func BindUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.events.asObservable()
            .bind(to: eventsTableView.rx
                    .items(cellIdentifier: "EventTableViewCell", cellType: EventTableViewCell.self)) { _, event, cell in
                cell.configure(with: event)
            }.disposed(by: disposeBag)
        
        eventsTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel?.didSelectModel(index: indexPath.row)
            }).disposed(by: disposeBag)
        
        
        viewModel.showLoadinIndicator.subscribe(onNext: { [weak self] value in
            if value {
                self?.showLoadingIndicator()
            } else {
                self?.hideLoadingIndicator()
            }
        }).disposed(by: disposeBag)
        
    }
}
