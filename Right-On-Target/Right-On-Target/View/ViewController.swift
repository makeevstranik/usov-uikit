//
//  ViewController.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 11.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var game = GameNumbers()
    
    override func loadView() {
        super.loadView()
        print("loadView")
        let versionLabel = UILabel(frame:  CGRect(x: 20, y: 30, width: 200, height: 20))
        versionLabel.text = "Version 1.1"
        self.view.addSubview(versionLabel)
        self.title = "Numbers"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        updateView()
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        print(sender.value)
    }
    
    @IBAction func checkPressed(_ sender: UIButton) {
        guard !game.isGameOver else {
            let alert = UIAlertController(title: "Game Over", message: "You get \(game.getScore) scores", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: {_ in self.game.recoverGame() }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        game.makeStep(for: slider.value)
        scoreLabel.text = game.getScore
    }
    
    func setSlider(for slider: UISlider) {
        slider.maximumValue = SliderValue.max.rawValue
        slider.minimumValue = SliderValue.min.rawValue
        slider.setValue(SliderValue.set.rawValue, animated: true)
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
       // self.present(secondViewController, animated: true, completion: nil)
       // self.show(secondViewController, sender: self)
    }
}

extension ViewController: ScoreDescribingProtocol {
    func updateView() {
        scoreLabel.text = "0"
        setSlider(for: slider)
    }
}
