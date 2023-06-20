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
        viewModel = RecipeFormViewModel(contentService: ContentSuccessStub(), recipeService: RecipeServiceSuccessStub(), recipeId: nil)
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
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsDisabled)
    }
    
    func test_When_TitleIsEmpty_Expect_PreviewButtonIsDisabled() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.description = "description"
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsDisabled)
    }
    
    func test_When_DescriptionIsEmpty_Expect_PreviewButtonIsDisabled() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.title = "Title"
        vm.recipeForm.thumbnail = "thumbnail"
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsDisabled)
    }
    
    func test_RecipeFormViewModel_previewButtonIsAvailable_shouldBeFalse3() {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        //  When
        vm.recipeForm.title = "Title"
        vm.recipeForm.thumbnail = "thumbnail"
        vm.recipeForm.steps.append(ContentWrappedStepForm())
        
        //  Then
        XCTAssertTrue(vm.previewButtonIsDisabled)
    }
    
    @MainActor
    func test_When__returnsOneURL() async {
        //  Given
        guard let vm = viewModel else {
            XCTFail()
            return
        }
        
        let response: ServiceResponse<ContentDTO> = ServiceResponse(message: "message", status: 200, data: .mock())
        
        //  When
        vm.updateMainImage(response)
        
        //  Then
        XCTAssertTrue(vm.recipeMetadataHasThumbnail)
    }
}
