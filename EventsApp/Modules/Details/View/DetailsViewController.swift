//
//  DetailsViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 06/09/2021.
//

import UIKit
import MapKit
import RxSwift
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var labelEventName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    var viewModel: DetailsViewModel?
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        viewModel?.loadEventData()
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        if let pin = viewModel?.createEventPin() {
            mapView.addAnnotation(pin)
            mapView.setCenter(pin.coordinate, animated: true)
        }
    }
    private func bindUI () {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.eventName.bind(to: labelEventName.rx.text).disposed(by: disposeBag)
        viewModel.eventDescription.bind(to: labelDescription.rx.text).disposed(by: disposeBag)
        viewModel.eventDate.bind(to: labelDate.rx.text).disposed(by: disposeBag)
        let _ = viewModel.eventImageUrl.subscribe { [weak self] urlStr in
            if let cachedImage = SDImageCache.shared().imageFromCache(forKey: urlStr.element) {
                self?.eventImageView.image = cachedImage
            } else if let strURL = urlStr.element,
                      !strURL.isEmpty,
                      let url = URL(string: strURL) {
                self?.eventImageView.sd_setImage(with: url, completed: nil)
            }
        }
    }

}
