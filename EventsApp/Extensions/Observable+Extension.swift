//
//  Observable+Extension.swift
//  EventsApp
//
//  Created by Mena Gamal on 05/09/2021.
//

import Foundation
import RxSwift
import RxCocoa
public extension Observable where Element == (HTTPURLResponse, Data){
    func expectingObject<T : Codable>(ofType type: T.Type) -> Observable<ApiResult<T, ApiErrorMessage>>{
        return self.map{ (httpURLResponse, data) -> ApiResult<T, ApiErrorMessage> in
            switch httpURLResponse.statusCode{
            case 200 ... 299:
                let object = try JSONDecoder().decode(type, from: data)
                return .success(object)
            default:
                // otherwise try
                return .failure(.failure)
            }
        }
    }
}


public enum ApiErrorMessage: Error {
    case failure
}


public enum ApiResult<Value, Error>{
    case success(Value)
    case failure(Error)

    init(value: Value){
        self = .success(value)
    }

    init(error: Error){
        self = .failure(error)
    }
}

