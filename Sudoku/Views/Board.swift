//
//  Board.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Board: View {
    @State var puzzle: [[Content]]
    @State var annotating = false
    @State var highlighting = false
    var body: some View {
        return HStack(alignment: .top) {
            Grid(rows: 3, columns: 3) { (squareRow, SquareColumn) in
                return Grid<Grid<Cell<Text>>>(rows: 3, columns: 3) { (cellRow, cellColumn) in
                    let square = squareRow * 3 + SquareColumn
                    let cell = cellRow * 3 + cellColumn
                    let value = self.puzzle[square][cell]
                    switch value {
                    case .fixed(let number):
                        return Grid(rows: 1, columns: 1) { (cellRow, cellColumn) in
                            Cell(frame: CGSize(width: 45, height: 45)) {
                                Text("\(number)")
                                    .font(.title)
                            }
                        }
                    case .options(let numbers):
                        return Grid(rows: 3, columns: 3, border: .gray) { (row, column) in
                            let option = row * 3 + column + 1
                            if numbers.contains(option) {
                                return Cell(frame: CGSize(width: 15, height: 15), border: .none) {
                                    Text("\(option)").foregroundColor(.gray)
                                        .font(.footnote)
                                }
                            } else {
                                return Cell(frame: CGSize(width: 15, height: 15), border: .none) {
                                    Text(" ")
                                }
                            }
                        }
                    case .selected(let number):
                        return Grid(rows: 1, columns: 1)  { (cellRow, cellColumn) in
                            Cell(frame: CGSize(width: 45, height: 45)) {
                                Text("\(number)").foregroundColor(.blue)
                                    .font(.title)
                            }
                        }
                    }

                }.border(Color.black, width: 2)
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 6)
            VStack(alignment: .leading) {
                Grid(rows: 3, columns: 3) { (row, column) in
                    Cell {
                        Text("\(row * 3 + column + 1)")
                    }
                }
                Toggle("Annotating", isOn: $annotating)
                Toggle("Highlighting", isOn: $highlighting)
            }
        }
    }
}

struct Board_Previews: PreviewProvider {
    static let puzzle: [[Content]] = [
        [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . selected(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .options([1, 2, 3, 4, 6, 7, 8, 9]), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.fixed(1), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.options([]), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)],
    [.options([1, 5, 9]), .fixed(2), . fixed(3), .fixed(4), . fixed(5), .fixed(6), .fixed(7), .fixed(8), .fixed(9)]
    ]
    static var previews: some View {
        Board(puzzle: puzzle)
    }
}
