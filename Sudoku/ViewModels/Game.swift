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
import AppKit

class Game: NSObject, ObservableObject {
    enum State {
        case playing, solved, invalid, designing
    }
    enum Mode {
        case playing(board: PlayingBoard)
        case designing(board: SudokuKit.Board)
        case disabled(message: String)
    }

    @Published var annotating: Bool
    @Published var highlighting: Bool
    @Published var mark: Int
    @Published var mode: Mode
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
        case .disabled:
            return PlayingBoard.CellState.fixed(0)
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
        case .disabled:
            break
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
            guard (board.board.reduce(0) { $1 != 0 ? $0 + 1 : $0 } >= 17 ) else { return false }
            DispatchQueue.global(qos: .userInitiated).async {
                let solver = Solver()
                let solutions = solver.solve(puzzle: board)
                DispatchQueue.main.async {
                    self.isUnique = solutions.count == 1
                }
            }
            return isUnique
        case .disabled:
            return false
        }
    }

    func newGame(given: Int = 36) {
        mode = .disabled(message: "Generating board")
        DispatchQueue.global(qos: .userInitiated).async {
            let board = PlayingBoard(given: given)
            DispatchQueue.main.async {
                self.startGame(board: board)
            }
        }
    }

    func designGame() {
        let board = SudokuKit.Board(board: [Int].init(repeating: 0, count: 81))
        mode = .designing(board: board)
        annotating = false
        highlighting = true
        mark = 0
        isUnique = false
    }

    func save() {
        let panel = NSSavePanel()
        panel.delegate = self
        panel.allowedFileTypes = ["sudoku"]
        panel.allowsOtherFileTypes = false
        panel.nameFieldStringValue = "MyBoard.sudoku"
        let result = panel.runModal()
        if result == .OK, let url = panel.url {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = [.withoutEscapingSlashes]
                encoder.dateEncodingStrategy = .iso8601
                var dataToSave: Data
                switch mode {
                case .playing(board: _):
                    //                dataToSave = try encoder.encode(board)
                    break
                case .designing(board: let board):
                    dataToSave = try encoder.encode(board.board)
                    try dataToSave.write(to: url)
                case .disabled:
                    break
                }
            } catch {
                print(error)
            }
        }
    }

    func load() {
        let panel = NSOpenPanel()
        panel.delegate = self
        panel.allowedFileTypes = ["sudoku"]
        panel.allowsOtherFileTypes = false
        let result = panel.runModal()
        if result == .OK, let url = panel.url {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let puzzle = try decoder.decode([Int].self, from: data)
                let board = SudokuKit.Board(board: puzzle)
                mode = .designing(board: board)
                annotating = false
                highlighting = true
                mark = 0
                isUnique = false
            } catch {
                print(error)
            }
        }
    }

    func playGame() {
        guard isUnique else { return }
        if case let Mode.designing(board: board) = mode {
            mode = .disabled(message: "Validating board")
            DispatchQueue.global(qos: .userInitiated).async {
                guard let puzzle = Puzzle(board: board) else { return }
                let board = PlayingBoard(puzzle: puzzle)
                DispatchQueue.main.async {
                    self.startGame(board: board)
                }
            }

        }
    }

    private func startGame(board: PlayingBoard) {
        mode = .playing(board: board)
        annotating = false
        highlighting = false
        mark = Int.random(in: 1...9)
        isUnique = true
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
        case .disabled:
            return nil
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
        case .disabled:
            return false
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

extension Game: NSOpenSavePanelDelegate {

}
