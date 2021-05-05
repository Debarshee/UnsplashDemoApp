//
//  ViewReusable.swift
//  MoviesInfoAppDemo
//
//  Created by Debarshee on 4/11/21.
//

import Foundation

protocol ViewReusable {
    static var cellIdentifier: String { get }
}

extension ViewReusable {
    static var cellIdentifier: String {
        String(describing: self)
    }
}
