//
//  SudokuCollectionViewCell.swift
//  sumSudoku
//
//  Created by Soo J on 2022/08/02.
//

import UIKit

protocol SendingStringInputDelegate {
    func getTextFieldInput(_ cell: SudokuCollectionViewCell, didChangedInput value: String)
}

class SudokuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userTextField: UITextField!
    var delegate: SendingStringInputDelegate?
    var row: Int = 0
    var column: Int = 0
    var stringInput: String = "" {
        willSet {
            self.userTextField.text = newValue
        }
    }
//    self.userTextField.delegate = self
    
}
    
extension SudokuCollectionViewCell: UITextFieldDelegate {
    
}
