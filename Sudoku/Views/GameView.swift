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
        if case let Game.Mode.disabled(message: message) = game.mode {
            return AnyView(
                HStack(alignment: .top) {
                    VStack {
                        Spacer()
                        Text(message)
                            .font(.title)
                            .padding()
                            .background(Color.yellow)
                            .frame(maxWidth: .infinity)
                            .padding()
                        Spacer()
                    }
                    SidePanel()
            })
        } else {
            return AnyView(HStack(alignment: .top) {
                Board()
                    .padding()
                SidePanel()
            })
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
