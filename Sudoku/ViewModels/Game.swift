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
import SwiftUI

class Game: ObservableObject {
    enum State {
        case playing, solved, invalid, designing
    }
    enum Mode {
        case playing(board: PlayingBoard)
        case designing(board: SudokuKit.Board)
    }

    @Published var annotating: Bool
    @Published var highlighting: Bool
    @Published var mark: Int
    @Published private var mode: Mode
    @Published private(set) var isUnique: Bool

    var state: State {
        if case let Mode.playing(board: playingBoard) = mode {
            switch playingBoard.state {
            case .playing:
                return .playing
            case .solved:
                return .solved
            case .invalid:
                return .invalid
            }
        } else {
            return .designing
        }
    }

    func valueAt(row: Int, column: Int) -> PlayingBoard.CellState {
        switch mode {
        case .playing(board: let board):
            return board[row, column]
        case .designing(board: let board):
            let index = row * 9 + column
            let value = board[index]
            if value == 0 {
                return PlayingBoard.CellState.annotations([])
            }
            return PlayingBoard.CellState.fixed(value)
        }
    }
    
    func mark(row: Int, column: Int) {
        switch mode {
        case .playing(board: var board):
            board.mark(row: row, column: column, with: mark, asAnnotation: annotating)
            mode = .playing(board: board)
        case .designing(board: var board):
            let index = row * 9 + column
            if board[index] == mark || mark == 0 {
                board[index] = 0
            } else {
                if board[index] == 0 {
                    board[index] = mark
                }
            }
            mode = .designing(board: board)
        }
    }

    func check() -> Bool {
        switch mode {
        case .playing(board: var board):
            annotating = false
            highlighting = false
            mark = 0
            let state = board.submit()
            mode = .playing(board: board)
            return state == .solved
        case .designing(board: let board):
            let solver = Solver()
            let solutions = solver.solve(puzzle: board)
            isUnique = solutions.count == 1
            return isUnique
        }
    }

    func newGame(given: Int = 36) {
        let board = PlayingBoard(given: given)
        mode = .playing(board: board)
        annotating = false
        highlighting = false
        mark = Int.random(in: 1...9)
        isUnique = true
    }

    func designGame() {
        let board = SudokuKit.Board(board: [Int].init(repeating: 0, count: 81))
        mode = .designing(board: board)
        annotating = false
        highlighting = true
        mark = 0
        isUnique = false
    }

    func playGame() {
        guard isUnique else { return }
        if case let Mode.designing(board: board) = mode {
            guard let puzzle = Puzzle(board: board) else { return }
            let board = PlayingBoard(puzzle: puzzle)
            mode = .playing(board: board)
            annotating = false
            highlighting = false
            mark = Int.random(in: 1...9)
            isUnique = true
        }
    }

    func isCorrect(row: Int, column: Int) -> Bool? {
        switch mode {
        case .playing(board: let board):
            return board.isCorrect(row: row, column: column)
        case .designing(board: let board):
            let index = row * 9 + column
            let value = board[index]
            let row = board.getRow(for: index)
            let column = board.getColumn(for: index)
            let square = board.getSquare(for: index)
            return row.filter { $0 == value }.count == 1
                && column.filter { $0 == value }.count == 1
                && square.filter  { $0 == value }.count == 1
        }
    }

    func isValidOption(row: Int, column: Int) -> Bool {
        switch mode {
        case .playing(board: let board):
            return board.isValidOption(value: mark, forRow: row, column: column)
        case .designing(board: let board):
            let index = row * 9 + column
            let row = board.getRow(for: index)
            let column = board.getColumn(for: index)
            let square = board.getSquare(for: index)
            return row.filter { $0 == mark }.count == 0
                && column.filter { $0 == mark }.count == 0
                && square.filter  { $0 == mark }.count == 0
        }
    }

    init(given: Int = 36) {
        let playingBoard = PlayingBoard(given: given)
        mode = .playing(board: playingBoard)
        annotating = false
        highlighting = false
        mark = Int.random(in: 1...9)
        isUnique = true
    }
}
