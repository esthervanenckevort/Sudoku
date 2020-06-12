//
//  Square.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Square: View {
    var row: Int
    var column: Int
    var body: some View {
        return Grid<BoardCell>(rows: 3, columns: 3) { (cellRow, cellColumn) in
            let index = self.row * 27 + cellRow * 9 + self.column * 3 + cellColumn
            let row = index / 9
            let column = index % 9
            return BoardCell(row: row, column: column)
        }.border(Color.black, width: 2)
    }
}

#if DEBUG
struct Square_Previews: PreviewProvider {
    static var previews: some View {
        Square(row: 0, column: 0)
    }
}
#endif
