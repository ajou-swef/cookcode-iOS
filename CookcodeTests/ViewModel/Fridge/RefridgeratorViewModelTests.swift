//
//  RefridgeratorViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/17.
//

import XCTest
@testable import Cookcode

final class RefridgeratorViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_When_ContainsType_Expected_RemoveType() {
        
        //  Given
        let vm = RefrigeratorViewModel(fridgeService: RefrigeratorSuccessService())
        guard let ingredientType = IngredientType.allCases.randomElement() else { return }
        
        //  When
        vm.ingredientTypeButtonTapped(ingredientType)
        
        //  Then
        XCTAssertFalse(vm.presentedIngredientTypes.contains(ingredientType))
    }
    
    func test_When_DoseNotContainsType_Expected_AppendType() {
        
        //  Given
        let vm = RefrigeratorViewModel(fridgeService: RefrigeratorSuccessService())
        guard let ingredientType = IngredientType.allCases.randomElement() else { return }
        vm.ingredientTypeButtonTapped(ingredientType)
        
        //  When
        vm.ingredientTypeButtonTapped(ingredientType)
        
        //  Then
        XCTAssertTrue(vm.presentedIngredientTypes.contains(ingredientType))
    }
    
}
