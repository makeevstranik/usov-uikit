//
//  RandomProtocol.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 14.03.2022.
//

import Foundation

struct Random {
    func getValue(from lowBound: Int, to hightBound: Int) -> Int {
        Int.random(in: lowBound...hightBound)
    }
    
    func getValue(from lowBound: Float, to hightBound: Float) -> Float {
        Float.random(in: lowBound...hightBound)
    }
    
}


