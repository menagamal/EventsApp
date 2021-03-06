//
//  NetworkManager.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

public protocol NetworkSession {
    func request<T: Codable>(target:NetworkCallsTarget, type:T.Type ) -> Observable<ApiResult<T, ApiErrorMessage>>
}

class NetworkManager: NetworkSession {
    
    lazy var session = Session.default
    
    func request<T: Codable>(target:NetworkCallsTarget, type:T.Type ) -> Observable<ApiResult<T, ApiErrorMessage>> {
        
        return session.rx
            .request(target.method, "\(target.baseUrl)\(target.endpoint)")
            .responseData()
            .expectingObject(ofType: type)
    }

}


public enum NetworkCallsTarget {
    
    case getCategories
    case fetchEvents(id:String)
    
    var baseUrl: String {
        return "http://private-7466b-eventtuschanllengeapis.apiary-mock.com/"
    }
    
    var endpoint: String {
        switch self {
        case .getCategories:
            return "eventtypes"
        case .fetchEvents(let id):
            return "events?event_type=\(id)"
        }
    }
    var method: HTTPMethod  {
        switch self {
        case .getCategories, .fetchEvents:
            return .get
        }
    }
    
}
