//
//  ViewController.swift
//  Navigation
//
//  Created by Евгений Макеев on 20.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    typealias C = Constants
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func toGreenScene(_ sender: UIButton) {
        guard let nextViewController = getViewController(C.ViewControllerId.green.rawValue) else { return }
        self.navigationController?.pushViewController(nextViewController, animated: true)
        printNavigationStack()
    }
    @IBAction func toYellowScene(_ sender: UIButton) {
        guard let nextViewController = getViewController(C.ViewControllerId.yellow.rawValue) else { return }
        self.navigationController?.pushViewController(nextViewController, animated: true)
        printNavigationStack()
    }
    @IBAction func toRootScene(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
        printNavigationStack()
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        printNavigationStack()
    }
    
    func getViewController(_ id: String) -> UIViewController? {
        storyboardInstance.instantiateViewController(withIdentifier: id)
    }
    
    // cross link is possible here,  -green- controller is already in stack
    // self.navigationController?.pushViewController(nextViewController, animated: true) WILL CREATE SECOND -green- nextViewController
    @IBAction func toGreenFromYellowPressed(_ sender: UIButton) {
        guard let controllers = self.navigationController?.viewControllers else { return }
        // avoid making the same instances in Nav. stack
        for controller in controllers {
            if controller.title == "-green-" {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
        printNavigationStack()
    }

    // for checking instances in stack
    func printNavigationStack() {
        let controllers = self.navigationController?.viewControllers
        print("Stack Count: \((controllers?.count)!)")
        controllers?.forEach{
            print("Stack title: \($0.title!)")
        }
    }
}

