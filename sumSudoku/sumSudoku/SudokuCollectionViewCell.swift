//
//  SudokuCollectionViewCell.swift
//  sumSudoku
//
//  Created by Soo J on 2022/08/02.
//

import UIKit

class SudokuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @objc func textFieldDidChage(_sender: Any?) {
        
    }
}

extension SudokuCollectionViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        MainViewController.twoDi
    
    }
}
