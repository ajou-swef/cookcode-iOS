//
//  RecipeFormViewModel_Tests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/04/26.
//

import XCTest
@testable import Cookcode

final class RecipeFormViewModel_Tests: XCTestCase {
    
    var viewModel: RecipeFormViewModel?
    
    override func setUpWithError() throws {
        viewModel = RecipeFormViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_RecipeFormViewModel_isAvailablePreviewButton_shouldBeTrue() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeMetadata.title = "Title"
        vm.mainImageData = Data()
        vm.stepForms.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsAvailable)
    }
    
    func test_RecipeFormViewModel_isAvailablePreviewButton_shouldBeFalse1() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.mainImageData = Data()
        vm.stepForms.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsAvailable)
    }
    
    func test_RecipeFormViewModel_isAvailablePreviewButton_shouldBeFalse2() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeMetadata.title = "Title"
        vm.stepForms.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsAvailable)
    }
    
    func test_RecipeFormViewModel_isAvailablePreviewButton_shouldBeFalse3() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeMetadata.title = "Title"
        vm.mainImageData = Data() 
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsAvailable)
    }
}
