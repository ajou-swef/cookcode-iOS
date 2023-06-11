//
//  CookieInteractable.swift
//  Cookcode
//
//  Created by 노우영 on 2023/06/11.
//

import Foundation

protocol CookieInteractable {
    var selectedCookie: CookieDetail? { get set }
    func cookieInteractButtonTapped(_ cookkie: CookieDetail)
    func avControll(_ selection: String)
}
