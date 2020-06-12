//
//  NewGameControlsView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct NewGameControls: View {
    @EnvironmentObject private var game: Game
    @State private var numberOfGivenTiles = 36.0
    var body: some View {
        Group {
            Spacer()
            Slider(value: $numberOfGivenTiles, in: 17...46, step: 1)
            HStack {
                Text("Given tiles:")
                Text("\(Int(self.numberOfGivenTiles))")
            }
            if self.numberOfGivenTiles < 27 {
                Text("Warning, generating board may take a long time.")
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            Button("New game") {
                self.game.newGame(given: Int(self.numberOfGivenTiles))
            }
            Button("Load game") {
                self.game.load()
            }
            Button("Design  game") {
                self.game.designGame()
            }
        }
    }
}

struct NewGameControlsView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameControls()
            .environmentObject(Game())
    }
}
