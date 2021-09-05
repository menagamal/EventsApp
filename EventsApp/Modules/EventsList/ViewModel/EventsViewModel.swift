//
//  EventsViewModel.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import RxSwift
import RxRelay

class EventsViewModel {
    private var network: NetworkSession

    private var disposeBag = DisposeBag()
 
    private var router: EventsListRouter
    private var id: String
    
    var events: BehaviorRelay<[EventModel]> = BehaviorRelay(value: [EventModel]())

    init(router:EventsListRouter, network: NetworkSession, id:String ) {
        self.router = router
        self.id = id
        self.network = network
    }
    func fetchEvents()  {
        network.request(target: .fetchEvents(id: id), type: [EventModel].self).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let value):
                self?.events.accept(value)
                break
            case .failure(_):
                break
            }
        }).disposed(by: disposeBag)
    }
}
