//
//  PlayableProtocol.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 14.03.2022.
//

import Foundation
protocol PlayableProtocol {
    associatedtype T
    var random: Random { get }
    func makeStep(for senderValue: T) -> Void
}
