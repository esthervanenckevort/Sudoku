//
//  ContentView.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI
import SudokuKit

struct ContentView: View {
    let model = MainScreen()

    var body: some View {
//        NavigationView {
//            NavigationLink(destination: Board(game: model.newGame())) {
//                Text("New Game")
//            }
//            .padding()
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
        GameView(game: model.newGame())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
