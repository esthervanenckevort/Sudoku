//
//  BoardCell.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct BoardCell: View {
    @ObservedObject var game: Game
    var row: Int
    var column: Int
    var body: some View {
        let value = game.board[row][column]
        var view: AnyView
        switch value {
        case .fixed(let number):
            view = AnyView(ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    Text("\(number)")
                        .font(.title)
                        .foregroundColor(.black)
                })
        case .options(let numbers):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    Grid<Cell<Text>>(rows: 3, columns: 3) { (cellRow, cellColumn) in
                        let option = cellRow * 3 + cellColumn + 1
                        return Cell(frame: CGSize(width: 15, height: 15), border: .clear) { Text(numbers.contains(option) ? "\(option)" : " ")
                            .foregroundColor(.gray)
                            .font(.footnote)
                        }
                    }
                })
        case .selected(let number):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                    Text("\(number)")
                        .foregroundColor(.blue)
                        .font(.title)
                })
        }
        return view.frame(width: 45, height: 45)
            .border(Color.gray, width: 1)
            .contentShape(Rectangle())
            .onTapGesture {
                self.game.mark(row: self.row, column: self.column)
            }
    }
}


struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell(game: Game(), row: 0, column: 0)
    }
}
