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
    
    
    
    var firstDimensionArray = [0,0,0,0,0,0,0,0,0]
    var twoDimensionArray = [[0,0,0],[0,0,0],[0,0,0]]
    var positionRange = 0...2
    var valueRange = 1...99
    
    var firstRandomVal: Int = 0
    var secondRandomVal: Int = 0
    var thirdRandomVal: Int = 0
    var firstRandomPosition: Int = 0
    var secondRandomPosition: Int = 0
    var thirdRandomPosition: Int = 0
    
    var firstRowSum: Int = 0
    var secondRowSum: Int = 0
    var thirdRowSum: Int = 0
    var firstColSum: Int = 0
    var secondColSum: Int = 0
    var thirdColSum: Int = 0
    
    var sudokuResult: Bool = false

    var currentInput = ["currentValue": 0, "currentRow": 0, "currentColumn": 0 ]
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func getTextFieldInput(didChangedInput value: String) {
        //텍스트필드에서 편집 끝나면 셀들 긁어와서 firstDimensionArray에 업데이트 후 콜렉션뷰 reload하기
        let cells = self.sudokuCollectionView.visibleCells
        for i in 0...8 {
            if let text = (cells[i] as! SudokuCollectionViewCell).userTextField.text {
                firstDimensionArray[i] = Int(text) ?? 0
            }
        }
        print(firstDimensionArray)
        sudokuCollectionView.reloadData()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    
//        sudokuCollectionView.getTextFieldInput(didChangedInput: textField.text ?? "")
        print("textFieldEndEditing")
        getTextFieldInput(didChangedInput: textField.text ?? "")
//        sudokuCollectionView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
//        self.userTextField.resignFirstResponder()
    }
    
    func createRandomNums(){
        firstRandomVal = Int.random(in: valueRange)
        secondRandomVal = Int.random(in: valueRange)
        thirdRandomVal = Int.random(in: valueRange)
    }
    
    func createRandomPosition(){
        var randomPositionRange = [0,1,2,3,4,5,6,7,8]
        randomPositionRange.shuffle()

        firstRandomPosition = randomPositionRange.popLast()!
        secondRandomPosition = randomPositionRange.popLast()!
        thirdRandomPosition = randomPositionRange.popLast()!
    }
    func placeRandomNums(){
        
        let cells = self.sudokuCollectionView.visibleCells
        for cell in cells {
            (cell as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = true
        }
        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(firstRandomVal)"
        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(secondRandomVal)"
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        
        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(thirdRandomVal)"
        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
    
    }
    
    func compareSumResults(){
        for i in 0...8 {
            if i/3 == 0 {
                firstRowSum += firstDimensionArray[i]
            } else if i/3 == 1 {
                secondRowSum += firstDimensionArray[i]
            } else if i/3 == 2 {
                thirdRowSum += firstDimensionArray[i]
            }
        }
        
        for i in 0...8 {
            if i%3 == 0 {
                firstColSum += firstDimensionArray[i]
            } else if i%3 == 1 {
                secondColSum += firstDimensionArray[i]
            } else if i%3 == 2 {
                thirdColSum += firstDimensionArray[i]
            }
        }
        
        if firstRowSum == secondRowSum, firstRowSum == thirdRowSum, firstRowSum == firstColSum, firstRowSum == secondColSum, firstRowSum == thirdColSum {
            sudokuResult = true
        }
    }
    func showResultAlert(){
        if firstDimensionArray.contains(0) {
            let alert = UIAlertController(title: "경고", message: "아직 숫자배치 안됨\n버튼을 눌러 게임을 시작하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: tapStartBtn(_:))
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        } else if sudokuResult == true {
            let alert = UIAlertController(title: "성공", message: "가로세로 합 맞추기 성공", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
        } else {
            let alert = UIAlertController(title: "실패", message: "가로세로 합 맞추기 실패\n리셋하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "새로", style: .destructive, handler: tapStartBtn(_:))
            let cancelAction = UIAlertAction(title: "이어서", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: false, completion: nil)
        }
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        createRandomNums()
        createRandomPosition()
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
        
        // 1.데이터 2중으로 생성할 필요 없음
        
        
        
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

        cell.userTextField.keyboardType = UIKeyboardType.numberPad
        cell.userTextField.keyboardAppearance = UIKeyboardAppearance.default
        cell.userTextField.returnKeyType = UIReturnKeyType.done
        cell.userTextField.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 On

//        currentInput.append(contentsOf: [cell.userTextField.text, cell.row, cell.column])
        
        cell.delegate = self
        cell.userTextField.delegate = self
        cell.index = indexPath.row
        cell.row = row
        cell.column = column
        cell.userTextField.text = "0"
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


