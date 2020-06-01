//
//  Grid.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Grid<Cell>: View where Cell: View{
    let rows: Int
    let columns: Int
    var border: Color? = .clear
    let cellProvider: (Int, Int) -> Cell
    var body: some View {
        return VStack {
            ForEach(0..<rows) { (row) in
                HStack(spacing: 0) {
                    ForEach(0..<self.columns) { (column) in
                        self.cellProvider(row, column)
                    }
                }
            }
        }.border(border ?? Color.clear)
    }
}

#if DEBUG
struct Grid_Previews: PreviewProvider {
    static var previews: some View {
        Grid(rows: 3, columns: 3) { (row, column) in
            return Cell {
                Text("\(row * 3 + column + 1)")
            }
        }
    }
}
#endif
