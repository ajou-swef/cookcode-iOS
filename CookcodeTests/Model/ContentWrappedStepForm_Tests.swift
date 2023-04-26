//
//  ContentWrappedStepForm_Tests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/04/26.
//

import XCTest
@testable import Cookcode

final class ContentWrappedStepForm_Tests: XCTestCase {
    
    var contentWrapedStepFrom: ContentWrappedStepForm?

    override func setUpWithError() throws {
        contentWrapedStepFrom = ContentWrappedStepForm()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ContentWrappedStepForm_fillAllRequiredInformation_shouldBeTrue() {
        //  Given
        guard var contentWrapedStepFrom = contentWrapedStepFrom else {
            XCTFail()
            return
        }
        let stepForm = StepForm(id: UUID().uuidString, title: "Title", description: "Description")
        
        //  When
        contentWrapedStepFrom.imageDatas.append(Data())
        contentWrapedStepFrom.stepForm = stepForm
        
        //  Then
        XCTAssertTrue(contentWrapedStepFrom.fillAllRequiredInformation)
    }
    
    func test_ContentWrappedStepForm_fillAllRequiredInformation_shouldBeFalse() {
        //  Given
        let stepFormWithoutTitle = StepForm(id: UUID().uuidString, title: "", description: "description")
        let stepFormWithoutDecription = StepForm(id: UUID().uuidString, title: "title", description: "")
        let stepForm = StepForm(id: UUID().uuidString, title: "title", description: "description")
        
        var cwstWithoutTitle: ContentWrappedStepForm = .init()
        cwstWithoutTitle.imageDatas.append(Data())
        cwstWithoutTitle.stepForm = stepFormWithoutTitle
        
        var cwstWithpoutDescription: ContentWrappedStepForm = .init()
        cwstWithpoutDescription.imageDatas.append(Data())
        cwstWithpoutDescription.stepForm = stepFormWithoutDecription
        
        var cwstWithoutImageData: ContentWrappedStepForm = .init()
        cwstWithoutImageData.stepForm = stepForm
        
        var cwstWihputVideo: ContentWrappedStepForm = .init()
        cwstWihputVideo.videoURLs.append(VideoURL(url: URL(filePath: "url")))
        
        let stress_cwst: [ContentWrappedStepForm] = [cwstWithoutTitle, cwstWithpoutDescription,
                                                     cwstWithpoutDescription, cwstWithoutImageData]
        
        for cwst in stress_cwst {
            //  When
            
            //  Then
            XCTAssertFalse(cwst.fillAllRequiredInformation)
        }
        
    }
    
    
}
