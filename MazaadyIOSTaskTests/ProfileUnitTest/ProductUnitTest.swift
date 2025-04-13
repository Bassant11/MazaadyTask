//
//  ProductUnitTest.swift
//  MazaadyIOSTask
//
//  Created by Mac on 13/04/2025.
//

import XCTest
import RxSwift
import RxCocoa
@testable import MazaadyIOSTask

class ProfileViewModelTests: XCTestCase {

    var viewModel: ProfileViewModel!
    var mockUseCase: MockProductsUseCase!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        // Create the mock use case and ViewModel instance before each test
        mockUseCase = MockProductsUseCase()
        viewModel = ProfileViewModel(useCase: mockUseCase)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        // Clean up the ViewModel and mock use case after each test
        viewModel = nil
        mockUseCase = nil
        disposeBag = nil
        super.tearDown()
    }

    // Test: Ensure isLoading is true when loading starts
    func testIsLoadingTrueWhenLoadingStarts() {
        // Given
        let expectation = self.expectation(description: "isLoading true")

        viewModel.isLoading
            .skip(1) // Skip initial value
            .subscribe(onNext: { isLoading in
                if isLoading == true {
                    expectation.fulfill() // Fulfill the expectation if isLoading is true
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.loadProducts()

        // Then
        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test: Ensure isLoading is false when loading finishes successfully
    func testIsLoadingFalseWhenLoadingFinishes() {
        // Given
        let expectation = self.expectation(description: "isLoading false")

        viewModel.isLoading
            .skip(1) // Skip initial value
            .subscribe(onNext: { isLoading in
                if isLoading == false {
                    expectation.fulfill() // Fulfill the expectation if isLoading is false
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.loadProducts()

        // Simulate a successful response from the mock use case
        mockUseCase.result = .success([Product(id: 1, name: "Product 1", price: 10)])

        // Then
        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test: Ensure products are set when loading finishes successfully
    func testProductsAreSetWhenLoadingSucceeds() {
        // Given
        let expectation = self.expectation(description: "Products are set")

        viewModel.products
            .subscribe(onNext: { products in
                if !products.isEmpty {
                    XCTAssertEqual(products.first?.name, "Product 1")
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.loadProducts()

        // Simulate a successful response from the mock use case
        mockUseCase.result = .success([Product(id: 1, name: "Product 1", price: 10)])

        // Then
        waitForExpectations(timeout: 2, handler: nil)
    }

    // Test: Ensure error is set when loading fails
    func testErrorIsSetWhenLoadingFails() {
        // Given
        let expectation = self.expectation(description: "Error is set")

        viewModel.error
            .subscribe(onNext: { error in
                if error != nil {
                    expectation.fulfill() // Fulfill the expectation if error is not nil
                }
            })
            .disposed(by: disposeBag)

        // When
        viewModel.loadProducts()

        // Simulate a failed response from the mock use case
        mockUseCase.result = .failure(.serverError)

        // Then
        waitForExpectations(timeout: 2, handler: nil)
    }
}

// Mock ProductsUseCase to simulate different scenarios
class MockProductsUseCase: ProductsUseCase {

    var result: Result<[Product], NetworkError>?

     func execute() -> Observable<Result<[Product], NetworkError>> {
        if let result = result {
            return Observable.just(result)
        }
        return Observable.empty()
    }
}
