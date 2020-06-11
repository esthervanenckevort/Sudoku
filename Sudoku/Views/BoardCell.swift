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
                        .foregroundColor(background)
                    Text("\(number)")
                        .font(.title)
                        .foregroundColor(color(for: number) ?? .black)
                })
        case .options(let numbers):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(background)
                    Grid<Cell<Text>>(rows: 3, columns: 3) { (cellRow, cellColumn) in
                        let option = cellRow * 3 + cellColumn + 1
                        return Cell(frame: CGSize(width: 15, height: 15), border: .clear) { Text(numbers.contains(option) ? "\(option)" : " ")
                            .foregroundColor(self.color(for: option) ?? .gray)
                            .font(.footnote)
                        }
                    }
                })
        case .selected(let number):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(background)
                    Text("\(number)")
                        .foregroundColor(color(for: number) ?? .blue)
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

    private func color(for number: Int) -> Color? {
        if game.highlighting {
            return number == game.mark ? .red : .gray
        }
        return nil
    }

    private var background: Color {
        guard game.highlighting else {
            return .clear
        }
        switch game.board[row][column] {
        case .fixed(_), .selected(_):
            return .clear
        case .options(_):
            return game.isValidOption(row: row, column: column) ? .white : .clear
        }
    }

}


struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell(game: Game(), row: 0, column: 0)
    }
}
