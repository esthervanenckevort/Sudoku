//
//  Cell.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

enum Content {
    case fixed(Int)
    case options(Set<Int>)
    case selected(Int)
}

struct Cell<Content>: View where Content: View {
    var frame = CGSize(width: 50, height: 50)
    var border: Color? = .gray
    var highlight: Color? = .clear
    var contentProvider: () -> Content
    var body: some View {
        contentProvider()
            .background(highlight ?? Color.clear)
            .frame(width: frame.width, height: frame.height, alignment: .center)
            .border(border ?? Color.clear)
    }
}

#if DEBUG
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell {
            Text("1")
        }
    }
}
#endif
