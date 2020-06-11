//
//  BoardView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Board: View {
    @EnvironmentObject private var game: Game
    var body: some View {
        Grid<Square>(rows: 3, columns: 3) { (row, column) in
            Square(row: row, column: column)
            }.padding(10)
            .border(Color.black, width: 6)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        Board()
            .environmentObject(Game())
    }
}
