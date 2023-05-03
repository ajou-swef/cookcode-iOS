//
//  AccountServiceTests.swift
//  CookcodeTests
//
//  Created by 노우영 on 2023/05/03.
//

import Alamofire
import XCTest
@testable import Cookcode

final class AccountServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_AccountService_signIn_success() async {
        //  Given
        let service = AccountService()
        
        //  When
        let result = await service.signIn(SignInForm(email: "nou0jid@ajou.ac.kr", password: "pass7034!!"))
        
        //  Then
        switch result {
        case .success(_):
            break
        case .failure(_):
            XCTFail()
        }
    }

}
