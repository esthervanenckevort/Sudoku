//
//  ContentView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var puzzle: [[Content]] = [
        [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)]
    ]
    var body: some View {
        Board(puzzle: puzzle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
