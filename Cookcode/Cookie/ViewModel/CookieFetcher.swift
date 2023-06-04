//
//  CookieFetcher.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/04.
//

import Foundation

protocol CookieFetcher: Pagenable {
    var cookieService: CookieServiceProtocol { get }
    var serviceAlert: ServiceAlert { get set }
}
