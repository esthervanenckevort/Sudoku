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
    @ObservedObject var game: Game

    var body: some View {
        return HStack(alignment: .top) {
            BoardView(game: game)
                .padding()
            VStack(alignment: .leading) {
                NumberGrid(number: $game.mark)
                Toggle("Annotating", isOn: $game.annotating)
                Toggle("Highlighting", isOn: $game.highlighting)
            }.padding([.top, .trailing, .bottom])
        }
    }
}

#if DEBUG
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(game: Game())
    }
}
#endif
