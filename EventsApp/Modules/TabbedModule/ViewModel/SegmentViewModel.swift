//
//  SegmentViewModel.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import RxSwift
import RxRelay
class SegmentViewModel {

    private var network: NetworkSession

    private var disposeBag = DisposeBag()
 
    private var router: TabbedRouter
    
    private(set) var categoriesDataSource = BehaviorSubject<[CategoryModel]>(value: [CategoryModel]())

    var showLoadinIndicator = BehaviorSubject<Bool>(value: false)

    init(router:TabbedRouter, network: NetworkSession ) {
        self.router = router
        self.network = network
    }

    func loadCategories()  {
        showLoadinIndicator.onNext(true)
        network.request(target: .getCategories,type: [CategoryModel].self ).subscribe(onNext: { [weak self] result in
            self?.showLoadinIndicator.onNext(false)
            switch result {
            case .success(let value):
                self?.categoriesDataSource.onNext(value)
                break
            case .failure(_):
                break
            }
        }).disposed(by: disposeBag)

    }
    
    func didSelectCategory(from index: Int) -> UIViewController? {
        if index > -1 {
            do {
                let id = try categoriesDataSource.value()[index].id ?? ""
                return router.loadEvents(with: id)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    
}
