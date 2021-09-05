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

    lazy var network = NetworkManager()

    private var disposeBag = DisposeBag()

    private(set) var categoriesDataSource = PublishSubject<[CategoryModel]>()

    func loadCategories()  {
        network.request(target: .getCategories,type: [CategoryModel].self ).subscribe(onNext: { [weak self] result in
            switch result {
            case .success(let value):
                self?.categoriesDataSource.onNext(value)
                break
            case .failure(_):
                break
            }
        }).disposed(by: disposeBag)

    }
    
}
