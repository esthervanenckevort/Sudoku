//
//  Cell.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 01-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct Cell<Content>: View where Content: View {
    var size = CGSize(width: 50, height: 50)
    var border: Color? = .gray
    var contentProvider: () -> Content
    var body: some View {
        contentProvider()
            .frame(width: size.width, height: size.height, alignment: .center)
            .border(border ?? Color.clear)
    }
}

#if DEBUG
struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell() {
            Text("1")
        }
    }
}
#endif
