//
//  EventTableViewCell.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import UIKit
import SDWebImage

class EventTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var eventsImageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    
    //MARK: Configure
    func configure(with event:EventModel) {
        if let cachedImage = SDImageCache.shared().imageFromCache(forKey: event.cover) {
            eventsImageView.image = cachedImage
        } else if let strURL = event.cover, !strURL.isEmpty, let url = URL(string: strURL) {
            eventsImageView.sd_setImage(with: url, completed: nil)
        }
        labelTitle.text = event.name ?? ""
        labelDescription.text = event.description ?? ""
        labelDate.text = event.start_date ?? ""
    }
    
}
