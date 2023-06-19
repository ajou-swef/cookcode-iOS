//
//  HomeRecipeViewModelTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/06/19.
//

import XCTest
import Combine
@testable import Cookcode

final class HomeRecipeViewModelTests: XCTestCase {

    var cancellable = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_onFetch_success() async throws {
        
        //  Given
        let service = RecipeSuccessServiceStub()
        let vm = HomeRecipeViewModel(recipeService: service)
        let curPage = vm.pageState.page
        let curCellCount = vm.contents.count
        
        let returnedCellCount = try await service.fetchRecipeCells(page: 0, size: 0, search: .all, sort: nil, month: nil, cookcable: nil).get().data.content.count
        
        
        //  When
        await vm.onFetch()
        
        //  Then
        
        do {
            // fetch 후 pageState는 1초 뒤에 바뀌니 이 시간동안 대기 
            try await Task.sleep(nanoseconds: 2000000000)
            XCTAssertEqual(vm.pageState, .wait(curPage + 1))
            XCTAssertEqual(vm.contents.count, curCellCount + returnedCellCount)
        } catch {
            
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
