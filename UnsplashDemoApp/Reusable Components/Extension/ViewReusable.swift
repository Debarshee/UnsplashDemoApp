//
//  ViewReusable.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/11/21.
//

import Foundation

protocol ViewReusable {
    static var identifier: String { get }
}

extension ViewReusable {
    static var identifier: String {
        String(describing: self)
    }
}
