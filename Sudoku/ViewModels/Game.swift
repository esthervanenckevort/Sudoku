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
    @Published private var playingBoard: PlayingBoard
    @Published var annotating: Bool
    @Published var highlighting: Bool
    @Published var mark: Int
    var state: PlayingBoard.GameState {
        playingBoard.state
    }

    func valueAt(row: Int, column: Int) -> PlayingBoard.CellState {
        playingBoard[row, column]
    }
    
    func mark(row: Int, column: Int) {
        playingBoard.mark(row: row, column: column, with: mark, asAnnotation: annotating)
    }

    func check() {
        annotating = false
        highlighting = false
        mark = 0
        _ = playingBoard.submit()
    }

    func newGame(given: Int = 36) {
        playingBoard = PlayingBoard(given: given)
        annotating = false
        highlighting = false
        mark = Int.random(in: 1...9)
    }

    func isCorrect(row: Int, column: Int) -> Bool {
        return playingBoard.isCorrect(row: row, column: column) ?? false
    }

    func isValidOption(row: Int, column: Int) -> Bool {
        return playingBoard.isValidOption(value: mark, forRow: row, column: column)
    }

    init(given: Int = 36) {
        playingBoard = PlayingBoard(given: given)
        annotating = false
        highlighting = false
        mark = Int.random(in: 1...9)
    }
}
