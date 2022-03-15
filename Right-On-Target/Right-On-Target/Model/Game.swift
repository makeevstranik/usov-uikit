//
//  Game.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 14.03.2022.
//

import Foundation
import UIKit


typealias C = Constants

class Game {
    fileprivate static let attempts: Int = 5
    fileprivate var steps: Int = Game.attempts
    var delegate: ScoreDescribingProtocol!
    fileprivate var score: Int = 0
    var getScore: String { String(score) }
    
    var isGameOver: Bool { steps == 0 }
    
    func recoverGame() {
        steps = Game.attempts
        score = 0
        delegate.updateView()
    }
}

class GameNumbers: Game, PlayableProtocol {

    var random = Random()
 
    func makeStep(for sliderValue: Float) {
        if !isGameOver {
            score += Int(SliderValue.max.rawValue - abs(random.getValue(from: SliderValue.min.rawValue, to: SliderValue.max.rawValue) - sliderValue))
            steps -= 1
        }
    }
}

class GameColors: Game, PlayableProtocol {
    
    var random = Random()
    var guessedColor: UIColor!
    var colors: [UIColor?] = Array(repeating: nil, count: C.numberOfColorButtons)
    

    func makeStep(for buttonTag: Int) {
        if !isGameOver {
            if guessedColor == colors[buttonTag] {
                score += 1
            }
            steps -= 1
            updateColors()
        }
    }
    
    func updateColors() {
        self.colors = colors.map{ _ in
            let red = random.getValue(from: 0, to: 255)
            let green = random.getValue(from: 0, to: 255)
            let blue = random.getValue(from: 0, to: 255)
            return UIColor(r: red, g: green, b: blue)
        }
        guessedColor = colors[random.getValue(from: 0, to: C.numberOfColorButtons - 1)]
        delegate.updateView()
    }
}

// MARK: - UIColor extension
extension UIColor {
    convenience init?(r: Int, g: Int, b: Int) {
        guard 0...255 ~= r && 0...255 ~= g && 0...255 ~= b else {
            return nil
        }
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: 1.0)
    }
    func strHex() -> String {
        let c = self.cgColor.components!
        let (r, g, b) = (Int(c[0] * 255), Int(c[1] * 255), Int(c[2] * 255))
        return String(format: "%02X%02X%02X", r, g, b)
    }
}


