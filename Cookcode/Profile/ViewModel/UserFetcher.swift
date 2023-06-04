//
//  UserFetcher.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

protocol UserFetcher: Pagenable {
    var accountService: AccountServiceProtocol { get }
    var serviceAlert: ServiceAlert { get set }
}
