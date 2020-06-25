//
//  GameView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI
import SudokuKit

struct GameView: View {
    @EnvironmentObject private var game: Game

    var body: some View {
        Group {
            if case Game.Mode.disabled(message: let message) = game.mode {
                HStack(alignment: .top) {
                    Message(message: message)
                    SidePanel()
                }
            } else {
                HStack(alignment: .top) {
                    Board()
                        .padding()
                    SidePanel()
                }
            }
        }
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(Game())
    }
}
#endif
