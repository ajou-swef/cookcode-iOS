//
//  RecipeFormViewModel_Tests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/04/26.
//

import XCTest
import Combine
@testable import Cookcode

final class RecipeFormViewModel_Tests: XCTestCase {
    
    var viewModel: RecipeFormViewModel?
    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = RecipeFormViewModel(contentService: ContentSuccessService(), recipeService: RecipeSuccessService())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_RecipeFormViewModel_previewButtonIsAvailable_shouldBeTrue() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.title = "Title"
        vm.mainImageData = Data()
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsDisabled)
    }
    
    func test_RecipeFormViewModel_previewButtonIsAvailable_shouldBeFalse1() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.mainImageData = Data()
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsDisabled)
    }
    
    func test_RecipeFormViewModel_previewButtonIsAvailable_shouldBeFalse2() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.title = "Title"
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsDisabled)
    }
    
    func test_RecipeFormViewModel_previewButtonIsAvailable_shouldBeFalse3() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.title = "Title"
        vm.mainImageData = Data() 
        
        //  Then
        XCTAssertFalse(vm.previewButtonIsDisabled)
    }
    
    @MainActor
    func test_RecipeFormViewModel_postImage_returnsOneURL() async {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }

        
        //  When
        vm.mainImageData = Data()
        await vm.postMainImage()
        
        //  Then
        XCTAssertTrue(vm.recipeMetadataHasThumbnail)
    }
}
