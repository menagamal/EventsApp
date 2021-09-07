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
    
    var events: PublishSubject<[EventModel]> = PublishSubject()
    var error: PublishSubject<ApiErrorMessage> = PublishSubject()
    var showLoadinIndicator = BehaviorSubject<Bool>(value: false)

    init(router:EventsListRouter, network: NetworkSession, id:String ) {
        self.router = router
        self.id = id
        self.network = network
    }
    func fetchEvents()  {
        showLoadinIndicator.onNext(true)
        network.request(target: .fetchEvents(id: id), type: [EventModel].self).subscribe(onNext: { [weak self] result in
            self?.showLoadinIndicator.onNext(false)
            switch result {
            case .success(let value):
                self?.events.onNext(value)
                break
            case .failure(let e):
                self?.error.onNext(e)
                break
            }
        }).disposed(by: disposeBag)
    }
    
    func didSelectModel(event: EventModel){
        router.navigate(to: .detailsViewController(dependancy: event))
    }
    
    func type() -> EventModel.Type {
        return EventModel.self
    }
}
