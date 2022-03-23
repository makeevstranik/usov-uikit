//
//  UpdatingWithPropertyProtocol.swift
//  Transfer
//
//  Created by Евгений Макеев on 21.03.2022.
//

import UIKit

//using this protocol in order to avoid strong connection between A and B controllers
protocol TransferChangeableProtocol: UIViewController {
    
    var updatingData: String { get set }
    func onDataUpdateWithDelegate(data: String)
    
}
