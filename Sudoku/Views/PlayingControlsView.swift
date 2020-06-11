//
//  PlayingControlsView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct PlayingControls: View {
    @ObservedObject var game: Game
    var body: some View {
        Group {
            NumberGrid(number: $game.mark)
            Toggle("Annotating", isOn: $game.annotating)
            Toggle("Highlighting", isOn: $game.highlighting)
            Spacer()

            Button("Check solution") {
                self.game.check()
            }
        }
    }
}

struct PlayingControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingControls(game: Game())
    }
}
