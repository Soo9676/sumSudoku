//
//  ViewController.swift
//  sumSudoku
//
//  Created by Soo J on 2022/08/01.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate, SendingStringInputDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    func updateTextFieldChange() {
//        let cells = self.sudokuCollectionView.visibleCells
//
//
//
//        for i in 0..<twoDimensionArray.endIndex^2 {
////            self.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
//            let textField = self.sudokuCollectionView.visibleCells[i].userTextField
//            let indexPaths = self.sudokuCollectionView.indexPath(for: cells[i])
//            textField.addTarget(self, action: #selector(SudokuCollectionViewCell.textFieldDidChange(_:)), for: .textFieldChanged())
//        }
//    }
    
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    
    @IBOutlet weak var sumRowStack: UIStackView!
    @IBOutlet weak var sumColumnStack: UIStackView!
    
    @IBOutlet weak var sumRowFirstlbl: UILabel!
    @IBOutlet weak var sumRowSecondlbl: UILabel!
    @IBOutlet weak var sumRowThirdlbl: UILabel!
    
    @IBOutlet weak var sumColFirstlbl: UILabel!
    @IBOutlet weak var sumColSecondlbl: UILabel!
    @IBOutlet weak var sumColThirdlbl: UILabel!
    
    @IBOutlet weak var isSumMatchlbl: UILabel!
    
    @IBOutlet weak var gameStartBtn: UIButton!
    @IBOutlet weak var gameCompleteBtn: UIButton!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    
    var twoDimensionArray = [[0,0,0],[0,0,0],[0,0,0]]
    var positionRange = 0...2
    var valueRange = 1...99
    
    var firstRandomVal: Int = 0
    var secondRandomVal: Int = 0
    var thirdRandomVal: Int = 0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    
        self.getTextFieldInput(self, didChangedInput: textField.text ?? "")
        print("textFieldEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
//        self.userTextField.resignFirstResponder()
    }
    
    func getTextFieldInput(_ cell: SudokuCollectionViewCell, didChangedInput value: String) {
//        let cells = self.collectionView.visibleCells
        twoDimensionArray[cell.row][cell.column] = Int(value) ?? 77
        sudokuCollectionView.reloadData()
        print(twoDimensionArray)
    }
    
    func createRandomNums(){
        firstRandomVal = Int.random(in: valueRange)
        secondRandomVal = Int.random(in: valueRange)
        thirdRandomVal = Int.random(in: valueRange)
    }
    
    func createRandomPosition(){
        var randomValue = Int.random(in: valueRange)
        var x = Int.random(in: positionRange)
        var y = Int.random(in: positionRange)
        if twoDimensionArray[x][y] == 0 {
            twoDimensionArray[x][y] = randomValue
        } else {
            createRandomPosition()
        }
        
        sudokuCollectionView.numberOfSections
    }
    func placeRandomNums(){
        
    }
    
    func compareSumResults(){
        
    }
    func showResultAlert(){
        
    }
    
    @objc func textFieldChanged() {
        
        self.sumRowFirstlbl.text = "\(twoDimensionArray[0].reduce(0, +))"
        self.sumRowSecondlbl.text = "\(twoDimensionArray[1].reduce(0, +))"
        self.sumRowThirdlbl.text = "\(twoDimensionArray[2].reduce(0, +))"
        
        self.sumColFirstlbl.text = "\(twoDimensionArray[0][0] + twoDimensionArray[0][1] + twoDimensionArray[0][2] )"
        self.sumColFirstlbl.text = "\(twoDimensionArray[1][0] + twoDimensionArray[1][1] + twoDimensionArray[1][2])"
        self.sumColFirstlbl.text = "\(twoDimensionArray[2][0] + twoDimensionArray[2][1] + twoDimensionArray[2][2])"
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        createRandomNums()
        placeRandomNums()
    }
    
    @IBAction func tapCompleteBtn(_ sender: Any) {
        compareSumResults()
        showResultAlert()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let i: Int = twoDimensionArray.endIndex - 1
        let j: Int = twoDimensionArray[i].endIndex - 1
        
        func countCell(firstD: Int, secondD: Int, arr: [[Int]]) -> Int {
            var totalCellCount: Int = 0
            for n in 0...firstD {
                totalCellCount += arr[n].count
            }
            return totalCellCount
        }
        
        
        
        return countCell(firstD: i, secondD: j, arr: twoDimensionArray)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCollectionViewCell", for: indexPath) as?
                SudokuCollectionViewCell else {
                return UICollectionViewCell()
            }
        let i: Int = twoDimensionArray.endIndex - 1
        let j: Int = twoDimensionArray[i].endIndex - 1
        
        let row = indexPath.row / (i + 1)
        let column = indexPath.row % (j + 1)
        let value = twoDimensionArray[row][column]
        
        cell.userTextField.keyboardType = UIKeyboardType.numberPad // 키보드 타입 영문자 패드로
        cell.userTextField.keyboardAppearance = UIKeyboardAppearance.dark // 키보드 스타일 어둡게
        cell.userTextField.returnKeyType = UIReturnKeyType.done
        cell.userTextField.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 On
        
        cell.delegate = self
        cell.userTextField.delegate = self
        cell.row = row
        cell.column = column
        cell.userTextField.text = "\(value)"
        if value == 0 {
            cell.userTextField.textColor = .red
        } else {
            cell.userTextField.textColor = .black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCollectionViewCell", for: indexPath) as?
            SudokuCollectionViewCell {
            cell.userTextField.becomeFirstResponder()
        }
        
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 3
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth - 1, height: cellHeight)
        
    }
}


