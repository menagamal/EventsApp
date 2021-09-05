//
//  DetailsViewModel.swift
//  EventsApp
//
//  Created by Mena Gamal on 06/09/2021.
//

import Foundation
import MapKit
import RxSwift

class DetailsViewModel {
    
    // OUTPUT
    var eventName = BehaviorSubject<String>(value: "")
    var eventDescription = BehaviorSubject<String>(value: "")
    var eventDate = BehaviorSubject<String>(value: "")
    var eventImageUrl = BehaviorSubject<String>(value: "")
    
    private var model: EventModel
    
    init(model: EventModel) {
        self.model = model
    }
    func loadEventData() {
        eventName.onNext(model.name ?? "")
        eventDescription.onNext(model.description ?? "")
        eventDate.onNext(model.start_date ?? "")
        eventImageUrl.onNext(model.cover ?? "")
    }
    
    func createEventPin() -> MapPin? {
        guard let latStr = model.latitude,
              let lonStr = model.longitude,
              let lat = Double(latStr),
              let lon = Double(lonStr) else {
            return nil
        }
        return  MapPin(
            title: model.name ?? "",
          locationName: model.name ?? "",
          discipline: "Event",
          coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
    }
    
}
