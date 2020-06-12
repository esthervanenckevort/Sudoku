// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


import Foundation
import SudokuKit

protocol BoardManaging {
//    var annotating: Bool { get }
//    var highlighting: Bool { get }
//    var mark: Int { get }
//    var state: PlayingBoard.GameState { get }
//    func valueAt(row: Int, column: Int) -> PlayingBoard.CellState
    func mark(row: Int, column: Int)
    func isCorrect(row: Int, column: Int) -> Bool
    func isValidOption(row: Int, column: Int) -> Bool
}
