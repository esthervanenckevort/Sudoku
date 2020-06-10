//
//  Cell.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Cell<Content>: View where Content: View {
    var frame = CGSize(width: 50, height: 50)
    var border: Color? = .gray
    var highlight: Color? = .clear
    var tapAction: () -> Void
    var contentProvider: () -> Content
    var body: some View {
        contentProvider()
            .background(highlight ?? Color.clear)
            .padding(1)
            .frame(width: frame.width, height: frame.height, alignment: .center)
            .border(border ?? Color.clear)
            .onTapGesture(count: 1, perform: self.tapAction)
    }
}

#if DEBUG
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell(tapAction: { print("Tapped")}) {
            Text("1")
        }
    }
}
#endif
