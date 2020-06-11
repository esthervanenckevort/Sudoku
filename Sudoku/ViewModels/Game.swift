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
    @Published var mark: Int = 1

    func mark(row: Int, column: Int) {
        switch board[row][column] {
        case .fixed(_):
            return
        case .options(var values):
            if annotating {
                values.toggle(mark)
                board[row][column] = .options(values)
            } else {
                board[row][column] = .selected(mark)
            }
        case .selected(let value):
            if value != mark {
                if annotating {
                    board[row][column] = .options(Set([mark]))
                } else {
                    board[row][column] = .selected(mark)
                }
            } else {
                board[row][column] = .options(Set.empty)
            }
        }
    }

    init() {
        guard let puzzle = Puzzle() else {
            fatalError("Failed to generate a new puzzle.")
        }
        self.puzzle = puzzle
        board = [[Value]]()
        mark = Int.random(in: 1...9)
        for index in 0..<81 {
            if index % 9 == 0 {
                board.append([Value]())
            }
            let cell = puzzle.puzzle[index] == 0 ? Value.options(Set()) : Value.fixed(puzzle.puzzle[index])
            board[index / 9].append(cell)
        }
    }
}

extension Set {
    static var empty: Set { return Self() }
    mutating func toggle(_ value: Element) {
        if contains(value) {
            remove(value)
        } else {
            insert(value)
        }
    }
}
