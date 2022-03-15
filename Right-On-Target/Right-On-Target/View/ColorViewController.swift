//
//  SecondViewController.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 12.03.2022.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var colorButton0: UIButton!
    @IBOutlet weak var colorButton1: UIButton!
    @IBOutlet weak var colorButton2: UIButton!
    @IBOutlet weak var colorButton3: UIButton!
    @IBOutlet weak var hintSegment: UISegmentedControl!
    
    var game = GameColors()
    var colorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtons = [colorButton0,
                            colorButton1,
                            colorButton2,
                            colorButton3]
        game.delegate = self
        game.updateColors()
    }
    
    override func loadView() {
        super.loadView()
        self.title = "Colors"
        scoreLabel.text = "0"
        hintSegment.selectedSegmentIndex = 0
    }
    
    @IBAction func button0Pressed(_ sender: UIButton) {
        colorButtonPressed(tag: sender.tag)
    }
    @IBAction func button1Pressed(_ sender: UIButton) {
        colorButtonPressed(tag: sender.tag)
    }
    @IBAction func button2Pressed(_ sender: UIButton) {
        colorButtonPressed(tag: sender.tag)
    }
    @IBAction func button3Pressed(_ sender: UIButton) {
        colorButtonPressed(tag: sender.tag)
    }
    
    @IBAction func hintSegmentChanged(_ sender: UISegmentedControl) {
        updateButtonHints()
    }
    
    func colorButtonPressed(tag: Int) {
        guard !game.isGameOver else {
            let alert = UIAlertController(title: "Game Over", message: "You get \(game.getScore) scores", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: {_ in
                self.scoreLabel.text = "0"
                self.game.recoverGame()
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        game.makeStep(for: tag)
        scoreLabel.text = game.getScore
    }
}

extension ColorViewController: ScoreDescribingProtocol {
    func updateView() {
        colorButtons.forEach{ button in
            button.tintColor = game.colors[button.tag]!
        }
        colorLabel.text = game.guessedColor.strHex()
        updateButtonHints()
    }
}

extension ColorViewController {
    func updateButtonHints() {
        switch hintSegment.selectedSegmentIndex {
            case 1: colorButtons.forEach({$0.setTitle(game.colors[$0.tag]?.strHex(), for: .normal)})
            case 0: colorButtons.forEach({$0.setTitle("", for: .normal)})
            default: colorButtons.forEach({$0.setTitle("", for: .normal)})
        }
    }
}
