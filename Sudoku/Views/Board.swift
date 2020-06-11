//
//  Board.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI
import SudokuKit

struct GameView: View {
    @ObservedObject var game: Game

    var body: some View {
        return HStack(alignment: .top) {
            Board(game: game)
            VStack {
                NumberGrid(number: $game.mark)
                Toggle("Annotating", isOn: $game.annotating)
                Toggle("Highlighting", isOn: $game.highlighting)
            }
        }
    }
}

struct Board: View {
    @ObservedObject var game: Game
    var body: some View {
        Grid<SquareView>(rows: 3, columns: 3) { (row, column) in
            SquareView(game: self.game, row: row, column: column)
        }.border(Color.black, width: 6)
    }
}



#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game())
    }
}
#endif
