//
//  DynamicLinksProtocol.swift
//  Noty
//
//  Created by Youssef Jdidi on 18/2/2021.
//

import FirebaseDynamicLinks

protocol DynamicLinksProtocol {
    func handleUniversalLink(_ url: URL, completion: @escaping (DynamicLink?, Error?) -> Void) -> Bool
    func dynamicLink(fromCustomSchemeURL url: URL) -> DynamicLink?
}

extension DynamicLinks: DynamicLinksProtocol {}
