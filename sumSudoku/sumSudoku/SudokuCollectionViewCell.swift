//
//  SudokuCollectionViewCell.swift
//  sumSudoku
//
//  Created by Soo J on 2022/08/02.
//

import UIKit

protocol SendingStringInputDelegate {
    func getTextFieldInput( didChangedInput value: String )
}

class SudokuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userTextField: UITextField!
    var delegate: SendingStringInputDelegate?
    var index: Int = 0
    var row: Int = 0
    var column: Int = 0
    var bgColor: UIColor = .white
    var stringInput: String = "" {
        willSet {
            self.userTextField.text = newValue
        }
    }
}

extension SudokuCollectionViewCell: SendingStringInputDelegate {
    func getTextFieldInput( didChangedInput value: String) {
//        MainViewController.twoDimensionArray[row][column] = Int(value) ?? 77
//        print(twoDimensionArray)
    }
}



