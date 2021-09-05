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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        segmentControll.rx.selectedSegmentIndex.subscribe(onNext: { index in
            // replace View controllers
        }).disposed(by: disposeBag)
    }
    
}

