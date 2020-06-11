//
//  SidePanel.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 11-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct SidePanel: View {
    @EnvironmentObject private var game: Game
    var body: some View {
       VStack(alignment: .leading) {
            if game.state == .playing {
                PlayingControls()
            }
            NewGameControls()
        }.padding([.top, .trailing, .bottom])
    }
}

struct SidePanel_Previews: PreviewProvider {
    static var previews: some View {
        SidePanel()
            .environmentObject(Game())
    }
}
