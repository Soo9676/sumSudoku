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
        
        setRowButton()
        setColButton()
        
        if sudokuRow == 2 {
            sumRowFirstlbl.isHidden = false
            sumRowSecondlbl.isHidden = false
            sumRowThirdlbl.isHidden = true
            sumRowFourthlbl.isHidden = true
            sumRowFifthlbl.isHidden = true
            
        } else if sudokuRow == 3 {
            sumRowFirstlbl.isHidden = false
            sumRowSecondlbl.isHidden = false
            sumRowThirdlbl.isHidden = false
            sumRowFourthlbl.isHidden = true
            sumRowFifthlbl.isHidden = true
            
        } else if sudokuRow == 4 {
            sumRowFirstlbl.isHidden = false
            sumRowSecondlbl.isHidden = false
            sumRowThirdlbl.isHidden = false
            sumRowFourthlbl.isHidden = false
            sumRowFifthlbl.isHidden = true
            
        } else if sudokuRow == 5 {
            sumRowFirstlbl.isHidden = false
            sumRowSecondlbl.isHidden = false
            sumRowThirdlbl.isHidden = false
            sumRowFourthlbl.isHidden = false
            sumRowFifthlbl.isHidden = false
            
        }
        
        if sudokuCol == 2 {
            sumColFirstlbl.isHidden = false
            sumColSecondlbl.isHidden = false
            sumColThirdlbl.isHidden = true
            sumColFourthlbl.isHidden = true
            sumColFifthlbl.isHidden = true
            
        } else if sudokuCol == 3 {
            sumColFirstlbl.isHidden = false
            sumColSecondlbl.isHidden = false
            sumColThirdlbl.isHidden = false
            sumColFourthlbl.isHidden = true
            sumColFifthlbl.isHidden = true
            
        } else if sudokuCol == 4 {
            sumColFirstlbl.isHidden = false
            sumColSecondlbl.isHidden = false
            sumColThirdlbl.isHidden = false
            sumColFourthlbl.isHidden = false
            sumColFifthlbl.isHidden = true
            
        } else if sudokuCol == 5 {
            sumColFirstlbl.isHidden = false
            sumColSecondlbl.isHidden = false
            sumColThirdlbl.isHidden = false
            sumColFourthlbl.isHidden = false
            sumColFifthlbl.isHidden = false
            
        }
        
        setSumLabelText()
        setSumMatchlblText()
    }
    @IBOutlet weak var optionsStack: UIStackView!
    @IBOutlet weak var optionRowLbl: UILabel!
    @IBOutlet weak var optionRowButton: UIButton!
    @IBOutlet weak var optionColLbl: UILabel!
    @IBOutlet weak var optionColButton: UIButton!
    
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    var minimumInterItemSpacing: CGFloat = 3 //cell, line 간 간격
    
    @IBOutlet weak var sumRowStack: UIStackView!
    @IBOutlet weak var sumColumnStack: UIStackView!
    
    @IBOutlet weak var sumRowFirstlbl: UILabel!
    @IBOutlet weak var sumRowSecondlbl: UILabel!
    @IBOutlet weak var sumRowThirdlbl: UILabel!
    @IBOutlet weak var sumRowFourthlbl: UILabel!
    @IBOutlet weak var sumRowFifthlbl: UILabel!
    
    @IBOutlet weak var sumColFirstlbl: UILabel!
    @IBOutlet weak var sumColSecondlbl: UILabel!
    @IBOutlet weak var sumColThirdlbl: UILabel!
    @IBOutlet weak var sumColFourthlbl: UILabel!
    @IBOutlet weak var sumColFifthlbl: UILabel!
   
    
    @IBOutlet weak var isSumMatchlbl: UILabel!
    
    @IBOutlet weak var gameStartBtn: UIButton!
    @IBOutlet weak var gameCompleteBtn: UIButton!
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    var sudokuRow: Int = 5
    var sudokuCol: Int = 5
    var cellCount: Int = 25
    
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
    var fourthRowSum: Int = 0
    var fifthRowSum: Int = 0
    
    var firstColSum: Int = 0
    var secondColSum: Int = 0
    var thirdColSum: Int = 0
    var fourthColSum: Int = 0
    var fifthColSum: Int = 0
    
    var isNonZeroNumExists: Bool = false
    var isSumnMatch: Bool = false

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    func setSumMatchlblText() {
        isSumMatchlbl.text = "\(isSumnMatch)"
    }
    
    func setSumLabelText() {
        sumRowFirstlbl.text = "\(firstRowSum)"
        sumRowSecondlbl.text = "\(secondRowSum)"
        sumRowThirdlbl.text = "\(thirdRowSum)"
        sumRowFourthlbl.text = "\(fourthRowSum)"
        sumRowFifthlbl.text = "\(fifthRowSum)"
        
        sumColFirstlbl.text = "\(firstColSum)"
        sumColSecondlbl.text = "\(secondColSum)"
        sumColThirdlbl.text = "\(thirdColSum)"
        sumColFourthlbl.text = "\(fourthColSum)"
        sumColFifthlbl.text = "\(fifthColSum)"
        
    }
    
    func setRowButton() {
        let rowClosure = { [self](action : UIAction) in
            print(action.title)
            self.sudokuRow = Int(action.title) ?? 5
            print("Row = \(sudokuRow)")
        }
        
        optionRowButton.menu = UIMenu(children : [
        UIAction(title: "2", handler: rowClosure),
        UIAction(title: "3", handler: rowClosure),
        UIAction(title: "4", handler: rowClosure),
        UIAction(title: "5", handler: rowClosure)])
        
        optionRowButton.showsMenuAsPrimaryAction = true
//        optionRowButton.changesSelectionAsPrimaryAction = true
    }
    
    func setColButton() {
        let colClosure = { [self](action : UIAction) in
            print(action.title)
            self.sudokuCol = Int(action.title) ?? 5
            print("Col = \(sudokuCol)")
        }
        
        optionRowButton.menu = UIMenu(children : [
        UIAction(title: "2", handler: colClosure),
        UIAction(title: "3", handler: colClosure),
        UIAction(title: "4", handler: colClosure),
        UIAction(title: "5", handler: colClosure)])
        
        optionColButton.showsMenuAsPrimaryAction = true
//        optionRowButton.changesSelectionAsPrimaryAction = true
    }
    
    func getTextFieldInput(didChangedInput value: String) {
        //텍스트필드에서 편집 끝나면 셀들 긁어와서 firstDimensionArray에 업데이트 후 콜렉션뷰 reload하기
        let cells = self.sudokuCollectionView.visibleCells
        print(value)
        
        for i in 0...(cellCount - 1) {
            if let text = (cells[i] as! SudokuCollectionViewCell).userTextField.text {
                let index = sudokuCollectionView.indexPath(for: cells[i])?.row
                firstDimensionArray[index ?? 0] = Int(text) ?? 0
                
            }
        }
        print(firstDimensionArray)
    }

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldBeginEditing")
        print(firstDimensionArray)
        if textField.text == "0" {
            textField.text = ""
        }
        
        //아직 숫자 배치가 안됐다면 게임을 시작하도록 경고창 띄
        for i in 0...(cellCount - 1) {
            if firstDimensionArray[i] == 0 {
                isNonZeroNumExists == true
            }
            
            if isNonZeroNumExists {
                showResultAlert()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    
//        sudokuCollectionView.getTextFieldInput(didChangedInput: textField.text ?? "")
        if textField.text == "" {
            textField.text == "0"
        }
        print("textFieldEndEditing")
        getTextFieldInput(didChangedInput: textField.text ?? "")
        resetSums()
        compareSumResults()
        setSumLabelText()
        isSumMatchlbl.text = "\(isSumnMatch)"
        if isSumnMatch == true {
            showResultAlert()
        }
        sudokuCollectionView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {

    }
    
    func createRandomNums(){
        firstRandomVal = Int.random(in: valueRange)
        secondRandomVal = Int.random(in: valueRange)
        thirdRandomVal = Int.random(in: valueRange)
    }
    
    func createRandomPosition(){
        var randomPositionRange:[Int] = []
        
        for i in 0...(cellCount - 1) {
            randomPositionRange.append(i)
        }
        randomPositionRange.shuffle()

        firstRandomPosition = randomPositionRange.popLast()!
        secondRandomPosition = randomPositionRange.popLast()!
        thirdRandomPosition = randomPositionRange.popLast()!
    }
    func placeRandomNums(){
        firstDimensionArray = []
        for _ in 0...(cellCount - 1) {
            firstDimensionArray.append(0)
        }
        
        let cells = self.sudokuCollectionView.visibleCells
        for cell in cells {
            (cell as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = true
            (cell as? SudokuCollectionViewCell)?.userTextField.text = "0"
            (cell as? SudokuCollectionViewCell)?.userTextField.backgroundColor = .systemYellow
        }
        //첫번째 랜덤 cell set
        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(firstRandomVal)"
        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        let firstRandomIndex = sudokuCollectionView.indexPath(for: cells[firstRandomPosition])

        (sudokuCollectionView.cellForItem(at: firstRandomIndex!) as! SudokuCollectionViewCell).userTextField.backgroundColor = .systemRed
//        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.backgroundColor = .systemRed
        
        (cells[firstRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        firstDimensionArray[firstRandomPosition] = firstRandomVal
        
        
        //두번째 랜덤 cell set
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(secondRandomVal)"
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        let secondRandomIndex = sudokuCollectionView.indexPath(for: cells[secondRandomPosition])
        
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.backgroundColor = .systemGreen
        
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
//        (sudokuCollectionView.cellForItem(at: secondRandomIndex!) as! SudokuCollectionViewCell).userTextField.backgroundColor = .clear
//        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.bgColor = .clear
//        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.backgroundColor = .clear
        firstDimensionArray[secondRandomPosition] = secondRandomVal
        
        //세번째 랜덤 cell set

        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.userTextField.text = "\(thirdRandomVal)"
        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
        let thirdRandomIndex = sudokuCollectionView.indexPath(for: cells[thirdRandomPosition])
        
        (sudokuCollectionView.cellForItem(at: thirdRandomIndex!) as! SudokuCollectionViewCell).userTextField.backgroundColor = .systemBlue
        
        (cells[secondRandomPosition] as? SudokuCollectionViewCell)?.userTextField.allowsEditingTextAttributes = false
//        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.bgColor = .clear
//        (cells[thirdRandomPosition] as? SudokuCollectionViewCell)?.userTextField.backgroundColor = .clear
        firstDimensionArray[thirdRandomPosition] = thirdRandomVal
        
        sudokuCollectionView.reloadData()
    }
    
    func resetSums() {
        firstRowSum = 0
        secondRowSum = 0
        thirdRowSum = 0
        fourthRowSum = 0
        fifthRowSum = 0
        
        firstColSum = 0
        secondColSum = 0
        thirdColSum = 0
        fourthRowSum = 0
        fifthRowSum = 0
    }
    
    func compareSumResults(){
        
        for i in 0...(cellCount - 1) {
            
            for j in 0...(sudokuCol - 1) {
                if i%sudokuCol == j {
                    firstColSum += firstDimensionArray[i]
                } else if i%sudokuCol == j {
                    secondColSum += firstDimensionArray[i]
                } else if i%sudokuCol == j {
                    thirdColSum += firstDimensionArray[i]
                } else if i%sudokuCol == j {
                    fourthColSum += firstDimensionArray[i]
                } else if i%sudokuCol == j {
                    fifthColSum += firstDimensionArray[i]
                }
            }
            
            for k in 0...(sudokuRow - 1) {
                if i/sudokuCol == k {
                    firstRowSum += firstDimensionArray[i]
                } else if i/sudokuCol == k {
                    secondRowSum += firstDimensionArray[i]
                } else if i/sudokuCol == k {
                    thirdRowSum += firstDimensionArray[i]
                } else if i%sudokuCol == k {
                    fourthRowSum += firstDimensionArray[i]
                } else if i%sudokuCol == k {
                    fifthRowSum += firstDimensionArray[i]
                }
            }
        }
        
        var rowSums = [firstRowSum, secondRowSum,thirdRowSum, fourthRowSum, fifthRowSum]
        var colSums = [firstColSum, secondColSum, thirdColSum, fourthColSum, fifthColSum]
        
        for i in 0...(sudokuRow - 2) {
            if rowSums[i] == rowSums[i+1] {
                isSumnMatch = true
            } else {
                isSumnMatch = false
            }
        }
        
        for i in 0...(sudokuCol - 2) {
            if colSums[i] == colSums[i+1] {
                isSumnMatch = true
            } else {
                isSumnMatch = false
            }
        }
    }
    
    func setFistDimensionArray() {
        firstDimensionArray = []
        for i in 0...(sudokuRow*sudokuCol - 1) {
            firstDimensionArray.append(0)
        }
    }
    
    @IBAction func tapStartBtn(_ sender: Any) {
        resetSums()
        print("HeadOfStart")
        setFistDimensionArray()
        print(firstDimensionArray)
        
        createRandomNums() //시작버튼에서만 호출
        createRandomPosition() //시작버튼에서만 호출
        placeRandomNums()
        compareSumResults()
        setSumLabelText()
        setSumMatchlblText()
//        inspectRandomNumHadSet()
        print([firstRandomVal,secondRandomVal,thirdRandomVal])
        
    
        print("TailOfStart")
        print(firstDimensionArray)
        
        
    }
    
    func showResultAlert(){
        if firstDimensionArray.contains(0) {
            let alert = UIAlertController(title: "경고", message: "아직 모든 숫자 입력 안됨\n버튼을 눌러 새게임을 시작하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: tapStartBtn(_:))
            let cancelAction = UIAlertAction(title: "아직 아님", style: .cancel, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: false, completion: nil)
        } else if isSumnMatch == true {
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
    
    @IBAction func tapCompleteBtn(_ sender: Any) {
        showResultAlert()
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

//MARK: UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let i: Int = twoDimensionArray.endIndex - 1
//        let j: Int = twoDimensionArray[i].endIndex - 1
//
//        func countCell(firstD: Int, secondD: Int, arr: [[Int]]) -> Int {
//            var totalCellCount: Int = 0
//            for n in 0...firstD {
//                totalCellCount += arr[n].count
//            }
//            return totalCellCount
//        }
        
        // 1.데이터 2중으로 생성할 필요 없음
        
//        return countCell(firstD: i, secondD: j, arr: twoDimensionArray)
        
        let cellCount = sudokuRow*sudokuCol
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCollectionViewCell", for: indexPath) as?
                SudokuCollectionViewCell else {
                return UICollectionViewCell()
            }
//        let i: Int = twoDimensionArray.endIndex - 1
//        let j: Int = twoDimensionArray[i].endIndex - 1
//
//        let row = indexPath.row / (i + 1)
//        let column = indexPath.row % (j + 1)
//        let value = twoDimensionArray[row][column]
        
        for i in 0...(cellCount - 1) {
            firstDimensionArray.append(0)
        }
        let value = firstDimensionArray[indexPath.row]

        cell.userTextField.keyboardType = UIKeyboardType.numberPad
        cell.userTextField.keyboardAppearance = UIKeyboardAppearance.default
        cell.userTextField.returnKeyType = UIReturnKeyType.done
        cell.userTextField.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 On
        
        cell.delegate = self
        cell.userTextField.delegate = self
        cell.index = indexPath.row
//        cell.row = row
//        cell.column = column
        cell.userTextField.text = "\(value)"
        cell.userTextField.textAlignment = .center
        cell.userTextField.backgroundColor = .clear
        if value == 0 {
            cell.userTextField.textColor = .white
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

//MARK: UICollectionViewFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = Int(collectionView.frame.width)
        let height = Int(collectionView.frame.height)
        let rows = self.sudokuRow
        let colummns = self.sudokuCol
        
        let cellWidth = (width - 3*(colummns - 1))/colummns
        let cellHeight = (height - 3*(rows - 1))/rows
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        let spacing = minimumInterItemSpacing
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let spacing = minimumInterItemSpacing
        return spacing
    }
}


