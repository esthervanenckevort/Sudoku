//
//  Square.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct SquareView: View {
    @ObservedObject var game: Game
    var row: Int
    var column: Int
    var body: some View {
        return Grid<BoardCell>(rows: 3, columns: 3) { (cellRow, cellColumn) in
            let index = self.row * 27 + cellRow * 9 + self.column * 3 + cellColumn
            let row = index / 9
            let column = index % 9
            return BoardCell(game: self.game, row: row, column: column)
        }.border(Color.black, width: 2)
    }
}

#if DEBUG
struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(game: Game(), row: 0, column: 0)
    }
}
#endif
