//
//  EventsViewModelTests.swift
//  EventsAppTests
//
//  Created by Mena Gamal on 07/09/2021.
//


import XCTest
import RxSwift
import UIKit

@testable import EventsApp

class EventsViewModelTests: XCTestCase {

    var viewModel: EventsViewModel?
    let router = EventsListRouter(rootViewController: UINavigationController())
    let disposeBag = DisposeBag()
    let successMock = NetworkSuccessMock()
    let failureMock = NetworkFailureMock()
    
    
    func testGetEventsSuccess() {
        let exp = self.expectation(description: "testGetEventsSuccess")
        viewModel = EventsViewModel(router: router, network: successMock, id: "")
        
        viewModel?.events.subscribe(onNext: { value in
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        
        viewModel?.fetchEvents()
        
        waitForExpectations(timeout: 3) { (_) in
            XCTAssert(true, "request time out")
        }
    }
    func testGetEventsFailure() {
        let exp = self.expectation(description: "testGetEventsFailure")
        viewModel = EventsViewModel(router: router, network: failureMock, id: "")
        
        viewModel?.error.subscribe(onNext: { value in
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        
        viewModel?.fetchEvents()
        
        waitForExpectations(timeout: 3) { (_) in
            XCTAssert(true, "request time out")
        }
    }

}
