//
//  NumberGrid.swift
//  Sudoku
//
//  Created by Esther van Enckevort on 10-06-2020.
//  Copyright © 2020 All things digital. All rights reserved.
//

import SwiftUI

struct NumberGrid: View {
    @Binding var number: Int
    var body: some View {
        Grid<Number>(rows: 3, columns: 3) { (row, column) in
            let value = row * 3 + column + 1
            return Number(selectedNumber: self.$number, value: value)
        }
    }
}
struct Number: View {
    @Binding var selectedNumber: Int
    var value: Int

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 45, height: 45)
                .foregroundColor(value == self.selectedNumber ? Color.yellow : Color.clear)
            Text("\(value)")
        }.contentShape(Rectangle())
            .border(Color.gray)
            .onTapGesture { self.selectedNumber = self.value}

    }

}

#if DEBUG
struct NumberGrid_Previews: PreviewProvider {
    static var previews: some View {
        NumberGrid(number: .constant(1))
    }
}
#endif
