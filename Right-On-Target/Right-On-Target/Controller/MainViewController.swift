//
//  MainViewController.swift
//  Right-On-Target
//
//  Created by Евгений Макеев on 13.03.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Game"
        // Do any additional setup after loading the view.
        print("MainViewDidLoad")
    }
    
    override func loadView() {
        super.loadView()
        print("MainLoadView")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("MainviewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MainviewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("MainviewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MainviewDidDisappear")
    }
}
