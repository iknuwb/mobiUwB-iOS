//
//  StringExtension.swift
//  MobiUwb
//
//  Created by Grzegorz Szymański on 19.08.2015.
//  Copyright (c) 2015 Grzegorz Szymański. All rights reserved.
//

import Foundation

extension String {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).componentsSeparatedByString(".").last!
    }
}