//
//  ViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import UIKit
import RxCocoa
import RxSwift
class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private let disposeBag = DisposeBag()
    
    private lazy var loader = ViewControllerLoader()
    private lazy var viewModel = SegmentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControll.removeAllSegments()
        bindUI()
        viewModel.loadCategories()
    }
    
    private func bindUI() {
        
        segmentControll.rx.selectedSegmentIndex.subscribe(onNext: { index in
            //Replace The View Controllers
        }).disposed(by: disposeBag)
    
        viewModel.categoriesDataSource.subscribe(onNext: { [weak self] value in
            let strs = value.map{ $0.name }.compactMap{ $0 }
            self?.segmentControll.replaceSegments(segments: strs)
            self?.segmentControll.selectedSegmentIndex = 0
        }).disposed(by: disposeBag)
    }
    
}

