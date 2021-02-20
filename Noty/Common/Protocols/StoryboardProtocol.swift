//
//  StoryboardProtocol.swift
//  Noty
//
//  Created by Youssef Jdidi on 11/2/2021.
//

import Foundation
import Swinject
import SwinjectStoryboard

protocol StoryboardId {
    var identifier: String { get }
}

protocol Storyboard {
    func initial<T: UIViewController>() -> T?
    func viewController<T: UIViewController>(identifier: StoryboardId) -> T?
}
