//
//  NetworkMock.swift
//  EventsAppTests
//
//  Created by Mena Gamal on 07/09/2021.
//

import Foundation
import RxSwift
@testable import EventsApp

class NetworkFailureMock: NetworkSession {
    func request<T>(target: NetworkCallsTarget, type: T.Type) -> Observable<ApiResult<T, ApiErrorMessage>> where T : Decodable, T : Encodable {
        let failure = ApiResult<T, ApiErrorMessage>(error: .failure)
        return Observable.of(failure)
    }
    
}


class NetworkSuccessMock: NetworkSession {
    func request<T>(target: NetworkCallsTarget, type: T.Type) -> Observable<ApiResult<T, ApiErrorMessage>> where T : Decodable, T : Encodable {
        
        switch target {
        case .getCategories:
            let categories = [CategoryModel()]
            let result = ApiResult<T, ApiErrorMessage>(value: categories as! T)
            return Observable.of(result)
        case .fetchEvents(id: _):
            let result = ApiResult<T, ApiErrorMessage>(value: [EventModel]() as! T)
            return Observable.of(result)
        }
    }
    
}
