//
//  Board.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI
import SudokuKit

struct Board: View {
    @ObservedObject var game: Game

    var body: some View {
        return HStack(alignment: .top) {
            BoardView(game: game)
            VStack {
                NumberGrid(number: $game.mark)
                Toggle("Annotating", isOn: $game.annotating)
                Toggle("Highlighting", isOn: $game.highlighting)
            }
        }
    }
}

struct BoardView: View {
    @ObservedObject var game: Game
    var body: some View {
        Grid<BoardSquare>(rows: 3, columns: 3) { (row, column) in
            BoardSquare(game: self.game, row: row, column: column)
        }.border(Color.black, width: 6)
    }
}

struct BoardSquare: View {
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
                    Grid<Text>(rows: 3, columns: 3) { (cellRow, cellColumn) in
                        let option = cellRow * 3 + cellColumn + 1
                        return Text(numbers.contains(option) ? "\(option)" : " ")
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                })
        case .selected(let number):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                    Text("\(number)")
                        .foregroundColor(.blue)
                        .font(.title)
                })
        }
        return view.frame(width: 45, height: 45)
            .border(Color.gray, width: 1)
            .onTapGesture {
                self.game.mark(row: self.row, column: self.column)
            }
    }
}

#if DEBUG
struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board(game: Game())
    }
}
#endif
