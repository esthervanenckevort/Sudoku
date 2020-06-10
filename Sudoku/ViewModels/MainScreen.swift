//
//  MainScreen.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 07-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import Foundation
import SudokuKit

class MainScreen: ObservableObject {

    // MARK:- Intents
    func newGame() -> Game {
        return Game()
    }
}
