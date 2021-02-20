//
//  AppError.swift
//  Noty
//
//  Created by Youssef Jdidi on 15/2/2021.
//

import Foundation

protocol AppError: Error {
    var title: String { get }
    var localizedDescription: String { get }
}
