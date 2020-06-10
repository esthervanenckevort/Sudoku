//
//  Game.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 10-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import Foundation
import Combine
import SudokuKit

class Game: ObservableObject {
    private var puzzle: Puzzle
    @Published var board = [[Value]]()
    @Published var annotating = false
    @Published var highlighting = false
    @Published var mark: Int = 0

    func mark(row: Int, column: Int) {
        objectWillChange.send()
        print("mark \(mark) (\(row), \(column))")
        switch board[row][column] {
        case .fixed(let value):
            print("ignoring  \(row), \(column) has fixed value \(value)")
            return
        case .options(var values):
            if annotating {
                print("annotating \(row), \(column) with: \(mark)")
                values.insert(mark)
                board[row][column] = .options(values)
            } else {
                print("solving  \(row), \(column) with: \(mark)")
                board[row][column] = .selected(mark)
            }
        case .selected(_):
            if annotating {
                print("annotating \(row), \(column) with: \(mark)")
                board[row][column] = .options(Set([mark]))
            } else {
                print("solving  \(row), \(column) with: \(mark)")
                board[row][column] = .selected(mark)
            }
        }
        print(board)
    }

    init() {
        guard let puzzle = Puzzle() else {
            fatalError("Failed to generate a new puzzle.")
        }
        self.puzzle = puzzle
        print(puzzle.puzzle)
        board = [[Value]]()
        for index in 0..<81 {
            if index % 9 == 0 {
                board.append([Value]())
            }
            let cell = puzzle.puzzle[index] == 0 ? Value.options(Set()) : Value.fixed(puzzle.puzzle[index])
            board[index / 9].append(cell)
        }
    }
}
