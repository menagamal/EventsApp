//
//  SegmentViewModelTests.swift
//  EventsAppTests
//
//  Created by Mena Gamal on 07/09/2021.
//

import XCTest
import RxSwift
import UIKit

@testable import EventsApp

class SegmentViewModelTests: XCTestCase {
    
    var viewModel: SegmentViewModel?
    let router = TabbedRouter(rootViewController: UINavigationController())
    let disposeBag = DisposeBag()
    let successMock = NetworkSuccessMock()
    let failureMock = NetworkFailureMock()
    
    
    func testGetCategorySuccess() {
        let exp = self.expectation(description: "GetCategorySuccess")
        viewModel = SegmentViewModel(router: router, network: successMock)
        
        viewModel?.categoriesDataSource.subscribe(onNext: { value in
            if !value.isEmpty {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        
        
        viewModel?.loadCategories()
        
        waitForExpectations(timeout: 3) { (_) in
            XCTAssert(true, "request time out")
        }
    }
    func testGetEventsFailure() {
        let exp = self.expectation(description: "testGetEventsFailure")
        viewModel = SegmentViewModel(router: router, network: failureMock)
        
        viewModel?.error.subscribe(onNext: { value in
            exp.fulfill()
        }).disposed(by: disposeBag)
        
        
        viewModel?.loadCategories()

        waitForExpectations(timeout: 3) { (_) in
            XCTAssert(true, "request time out")
        }
    }
    
}
