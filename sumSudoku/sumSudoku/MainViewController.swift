//
//  ViewController.swift
//  sumSudoku
//
//  Created by Soo J on 2022/08/01.
//

import UIKit

class MainViewController: UIViewController {

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
    
    
    var twoDimensionArray = [[0,0,0],[0,0,0],[0,0,0]]
    var positionRange = 0...2
    var valueRange = 1...99
    
    var firstRandomVal: Int = 0
    var secondRandomVal: Int = 0
    var thirdRandomVal: Int = 0
    
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
        var collectionCount: Int = 9
//        if let i = twoDimensionArray.endIndex {
//            if let j = twoDimensionArray[i].endIndex {
//                 collectionCount = 3*i + j + 1
//            }
//        }
        return collectionCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SudokuCollectionViewCell", for: indexPath) as?
                SudokuCollectionViewCell else {
                return UICollectionViewCell()
            }
        let row = indexPath.row/3
        let column = indexPath.row%3
        let value = twoDimensionArray[row][column]
        cell.userTextField.text = "\(value)"
        if value == 0 {
            cell.userTextField.textColor = .red
        } else {
            cell.userTextField.textColor = .black
        }
            
        return cell
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
        
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
}


