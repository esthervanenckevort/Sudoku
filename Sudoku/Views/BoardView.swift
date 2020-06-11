//
//  BoardView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    @ObservedObject var game: Game
    var body: some View {
        Grid<SquareView>(rows: 3, columns: 3) { (row, column) in
            SquareView(game: self.game, row: row, column: column)
            }.padding(10)
            .border(Color.black, width: 6)
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(game: Game())
    }
}
