//
//  ViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: BaseViewController {
    
    // MARK: Outlets
    @IBOutlet weak var segmentControll: UISegmentedControl!
    @IBOutlet weak var containerView: UIView!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: SegmentViewModel?
    
    var childViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Events"
        TabbedViewControllerBuilder().instantiate(viewController: self)
        segmentControll.removeAllSegments()
        bindUI()
        
        viewModel?.loadCategories()
    }
    
    private func bindUI() {

        segmentControll.rx.selectedSegmentIndex.subscribe(onNext: { [weak self] index in
            if let vc = self?.viewModel?.didSelectCategory(from: index) {
                self?.addViewController(viewController: vc)
            }
        }).disposed(by: disposeBag)

        viewModel?.categoriesDataSource.subscribe(onNext: { [weak self] value in
            if !value.isEmpty {
                let strs = value.map{ $0.name }.compactMap{ $0 }
                self?.segmentControll.replaceSegments(segments: strs)
                self?.segmentControll.selectedSegmentIndex = 1
                if let vc = self?.viewModel?.didSelectCategory(from: 1) {
                    self?.addViewController(viewController: vc)
                }
            }
        }).disposed(by: disposeBag)
        
        viewModel?.showLoadinIndicator.subscribe(onNext: { [weak self] value in
            if value {
                self?.showLoadingIndicator()
            } else {
                self?.hideLoadingIndicator()
            }
        }).disposed(by: disposeBag)
        
        
        viewModel?.error.subscribe(onNext: { [weak self] value in
            DispatchQueue.main.async {
                self?.display(message: value.message)
            }
        }).disposed(by: disposeBag)
        
        
    }
    
    func addViewController(viewController: UIViewController)  {

        if let vc = childViewController {
            vc.willMove(toParent: nil)
            vc.view.removeFromSuperview()
            vc.removeFromParent()
        }

        self.addChild(viewController)
        viewController.view.frame = containerView.bounds
        self.containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController = viewController
    }

}

