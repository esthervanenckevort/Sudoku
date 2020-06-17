//
//  PlayingControlsView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct PlayingControls: View {
    @EnvironmentObject private var game: Game
    var body: some View {
        Group {
            NumberGrid(number: $game.mark)
            if game.state == .playing {
                Toggle("Annotating", isOn: $game.annotating)
                Toggle("Highlighting", isOn: $game.highlighting)
            }
            Button("Check solution") {
                _ = self.game.check()
            }
            if game.state == .designing && game.isUnique {
                Button("Play game") {
                    self.game.playGame()
                }
                Button("Save puzzle") {
                    self.game.save()
                }
            }
        }
    }
}

struct PlayingControlsView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingControls()
            .environmentObject(Game())
    }
}
