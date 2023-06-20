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
            XCTFail("sleep 에러")
        }
    }
    
    func test_onFetch_failure() async throws {
        
        //  Given
        let vm = HomeRecipeViewModel(recipeService: RecipeFailureServiceStub())
        let originCellCount = vm.contents.count
        
        //  When
        await vm.onFetch()
        
        //  Then
        do {
            // fetch 후 pageState는 1초 뒤에 바뀌니 이 시간동안 대기
            try await Task.sleep(nanoseconds: 2000000000)
            XCTAssertEqual(vm.pageState, .noRemain)
            XCTAssertEqual(vm.contents.count, originCellCount)
        } catch {
            XCTFail("sleep 에러")
        }
    }
    
    func test_onRefresh() async throws {
        //  Given
        let service = RecipeSuccessServiceStub()
        let vm = HomeRecipeViewModel(recipeService: service)
        vm.pageState = .wait(Int.random(in: 1..<100))
        let returnedCellCount = try await service.fetchRecipeCells(page: 0, size: 0, search: .all, sort: nil, month: nil, cookcable: nil).get().data.content.count
        
        //  When
        await vm.onRefresh()
        
        //  Then
        do {
            // fetch 후 pageState는 1초 뒤에 바뀌니 이 시간동안 대기
            try await Task.sleep(nanoseconds: 2000000000)
            
            let expectedPageState: PageState = .wait(1)
            let actualPagesState: PageState = vm.pageState
            XCTAssertEqual(actualPagesState, expectedPageState)
            
            let expectedCellCount = returnedCellCount
            let actualCellCount = vm.contents.count
            XCTAssertEqual(actualCellCount, expectedCellCount)
        } catch {
            XCTFail("sleep 에러")
        }
    }
    
    func test_updateCell_delete() async {
        //  Given
        let vm = HomeRecipeViewModel(recipeService: RecipeSuccessServiceStub())
        vm.contents = RecipeCell.mocks(100)
        
        guard let selctedCell = vm.contents.randomElement() else {
            XCTFail("Reciecell.mocks 에러")
            return
        }
        var info: [CellType: CellUpdateInfo] = .init()
        info[.recipe] = CellUpdateInfo(updateType: .delete, cellId: selctedCell.recipeId)
        
        //  When
        await vm.updateCell(info)
        
        //  Then
        let actual = vm.contents.firstIndex { $0 == selctedCell }
        XCTAssertNil(actual)
    }
}
