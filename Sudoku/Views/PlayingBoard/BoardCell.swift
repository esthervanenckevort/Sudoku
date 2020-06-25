//
//  BoardCell.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct BoardCell: View {
    @EnvironmentObject private var game: Game
    var row: Int
    var column: Int
    var body: some View {
        let value = game.valueAt(row: row, column: column)
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
        case .annotations(let numbers):
            view = AnyView(
                ZStack {
                    Rectangle()
                        .foregroundColor(background)
                    Grid<Cell<Text>>(rows: 3, columns: 3) { (cellRow, cellColumn) in
                        let option = cellRow * 3 + cellColumn + 1
                        return Cell(size: CGSize(width: 15, height: 15), border: .clear) { Text(numbers.contains(option) ? "\(option)" : " ")
                            .foregroundColor(color(for: option) ?? .gray)
                            .font(.footnote)
                        }
                    }
                })
        case .solution(let number):
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
                game.mark(row: self.row, column: self.column)
            }
    }

    private func color(for number: Int) -> Color? {
        if game.highlighting {
            return number == game.mark ? .red : .gray
        }
        return nil
    }

    private var background: Color {
        switch game.state {
        case .designing:
            return game.isValidOption(row: row, column: column) ? .white : .clear
        case .invalid:
            return game.isCorrect(row: row, column: column) ?? false ? .green : .red
        case .solved:
            return .green
        case .playing:
            if game.highlighting {
                switch game.valueAt(row: row, column: column) {
                case .fixed(_), .solution(_):
                    return .clear
                case .annotations(_):
                    return game.isValidOption(row: row, column: column) ? .white : .clear
                }
            } else {
                return .clear
            }
        }
    }

}


struct BoardCell_Previews: PreviewProvider {
    static var previews: some View {
        BoardCell(row: 0, column: 0)
            .environmentObject(Game())
    }
}
