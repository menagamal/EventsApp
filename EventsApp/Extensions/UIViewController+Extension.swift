//
//  UIViewController+Extension.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import UIKit
extension UIViewController{

    func showError(error:String, btnAction:(()->Void)! = nil){
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        let done = UIAlertAction(title: NSLocalizedString("ok", comment: "ok"), style: .default) { (action) in
            if btnAction != nil {
                btnAction()
            }
        }
        alert.addAction(done)
        self.present(alert,animated: true)
    }
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    class func instanceXib<T: UIViewController>() -> T {
        return T(nibName: T.identifier, bundle: nil)
    }
}
