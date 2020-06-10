//
//  Content.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 10-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import Foundation

enum Value: Equatable {
    case fixed(Int)
    case options(Set<Int>)
    case selected(Int)
}
