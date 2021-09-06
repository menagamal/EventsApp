//
//  BaseViewController.swift
//  EventsApp
//
//  Created by Mena Gamal on 06/09/2021.
//

import UIKit
import Toast_Swift
protocol BaseViewProtocol: class {
    func display(message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func showLoadingRefresher()
    func hideLoadingRefresher()
    
}

class BaseViewController: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    
    private var indicator: LoadingView!
    var refresher: UIRefreshControl!
    var isConnected = true
    var connectionLabel: UILabel!
    var connectionFailure: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator = LoadingView()
    }
    
    func listToNetworkChange() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(onRechabilityChanged(_:)), name: .onRechabilityChanged, object: nil)
        connectionFailure = false
    }
}

extension BaseViewController: BaseViewProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func connectionView() {
        connectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 20))
        connectionLabel.textColor = .white
        connectionLabel.textAlignment = .center
        view.addSubview(connectionLabel)
    }
    
    func animateConnectionLabel(_ isConnected: Bool) {
        if isConnected {
            connectionLabel.text = "Internet connected!"
            connectionLabel.backgroundColor = .green
        } else {
            connectionLabel.text = "No internet connection"
            connectionLabel.backgroundColor = .red
        }
    }
    func setNavigation()  {
        UINavigationBar.appearance().tintColor = UIColor.white //your desired color here
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -12, vertical: 0), for: .default)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.start()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.indicator.stop()
        }
    }
    
    func showLoadingRefresher() {
        DispatchQueue.main.async {
            self.refresher.beginRefreshing()
        }
    }
    
    func hideLoadingRefresher() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            //    self.refresher.endRefreshing()
            
        })
    }
    
    func display(message: String) {
        print(message)
        show(message: message)
    }
    
    
    @IBAction func goToBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func onRechabilityChanged(_ notification:Notification) {
        if let status = notification.object as? Bool {
            showInternetStatus(status)
        }
    }
    
    func showInternetStatus(_ isConnected: Bool) {
        DispatchQueue.main.async {
            var title = ""
            var style = ToastStyle()
            style.cornerRadius = 20.0
            style.messageColor = .white
            self.hideToast()
            if isConnected {
                title = "Successfully connected to the internet"
                style.backgroundColor = Palette.connectionColor
            } else {
                title = "Sorry, no internet connections"
                style.backgroundColor = Palette.noConnectionColor
            }
            self.view.makeToast(title, duration: 2.0, position: .top, style: style) { didTap in }
        }
    }
    
    func hideToast() {
        self.view.hideToast()
    }
}

extension BaseViewController {
    private func show(message: String) {
        DispatchQueue.main.async {
            var alert = UIAlertController()
            let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(ok)
            self.present(alert,animated: true)
        }
    }
}

extension Notification.Name {

    static let onRechabilityChanged = Notification.Name("onRechabilityChanged")
    
}
