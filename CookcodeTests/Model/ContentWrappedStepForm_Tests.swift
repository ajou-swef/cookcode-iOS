////
////  ContentWrappedStepForm_Tests.swift
////  CookcodeTests
////
////  Created by 노우영 on 2023/04/26.
////
//
//import XCTest
//import PhotosUI
//@testable import Cookcode
//import _PhotosUI_SwiftUI
//
//final class ContentWrappedStepForm_Tests: XCTestCase {
//    
//    var contentWrapedStepFrom: ContentWrappedStepForm?
//
//    override func setUpWithError() throws {
//        contentWrapedStepFrom = ContentWrappedStepForm()
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//    
//    func test_ContentWrappedStepForm_fillAllRequiredInformation_shouldBeTrue() {
//        //  Given
//        guard var contentWrapedStepFrom = contentWrapedStepFrom else {
//            XCTFail()
//            return
//        }
//        
//        //  When
//        contentWrapedStepFrom.appendContetURLs(["https://picsum.photos/200"])
//        contentWrapedStepFrom.stepForm = stepForm
//        
//        //  Then
//        XCTAssertTrue(contentWrapedStepFrom.containsAllRequiredInformation)
//    }
//    
//    func test_ContentWrappedStepForm_fillAllRequiredInformation_shouldBeTrue() {
//        //  Given
//        guard var contentWrapedStepFrom = contentWrapedStepFrom else {
//            XCTFail()
//            return
//        }
//        let stepForm = StepForm(id: UUID().uuidString, title: "Title", description: "Description")
//        
//        //  When
//        contentWrapedStepFrom.appendContetURLs(["https://picsum.photos/200"])
//        contentWrapedStepFrom.stepForm = stepForm
//        
//        //  Then
//        XCTAssertTrue(contentWrapedStepFrom.containsAllRequiredInformation)
//    }
//}
