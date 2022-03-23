//
//  ViewController.swift
//  Transfer
//
//  Created by Евгений Макеев on 21.03.2022.
//

import UIKit

class ViewControllerA: UIViewController, TransferChangeableProtocol {
    
    
    var updatingData: String = "Test Data"
    

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var textFieldA: UITextField!
    
    // weak var turns to nil in func setDelegatePressed
    var delegateB: ViewControllerB!
    
    // check if weak for delegate is really needed here
    deinit {
        print("From A Class: \(self.debugDescription) is nil")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegateB = getController(storyboardId: "SecondViewController") as? ViewControllerB
        print(delegateB!)
       // updateLabel(with: updatingData)
    }
    
    // send data to controllerB
    @IBAction func changeWithProperty(_ sender: UIButton) {
        let controllerB = getController(storyboardId: "SecondViewController")
        controllerB.updatingData = dataLabel.text ?? "no text from A"
        self.navigationController?.pushViewController(controllerB, animated: true)
        printNavigationStack()
    }
    
    @IBAction func changeBySeguePressed(_ sender: UIButton) {
        // this button is connected with segue by storyboard!
        // segue Action /ControllerB show/
        // func prepareSceneB(_ segue: UIStoryboardSegue) is being calling automatically when button has pressed
    }
    
    @IBAction func unwindToControllerA(_ segue: UIStoryboardSegue) {
        // doesn't need to be coded!!!!!
        // this func will automatically appear in case of connection view from controllerB and top icon /Exit/
    }
    @IBAction func setDelegatePressed(_ sender: UIButton) {
        
        delegateB.updatingData = textFieldA.text ?? "no text from A"
        print("in setDelegatePressed:", delegateB!)
        self.navigationController?.pushViewController(delegateB, animated: true)
    }
    
    @IBAction func setClosureInBPressed(_ sender: UIButton) {
        delegateB.completionClosure = { [unowned self] updateValue in
            self.textFieldA.text = updateValue
            print("In Closure - updateValue- \(updateValue)")
        }
        self.navigationController?.pushViewController(delegateB, animated: true)
    }
    
    func updateLabel(with text: String) {
        self.dataLabel.text = text
    }
    
    func printNavigationStack() {
        let controllers = self.navigationController?.viewControllers
        print("Stack Count: \((controllers?.count)!)")
        controllers?.forEach{
            print("Stack title: \($0.title!)")
        }
    }
    
    private func getController(storyboardId: String) -> TransferChangeableProtocol {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! TransferChangeableProtocol
    }
    
}
// MARK: - Prepare Extension
extension ViewControllerA {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "toControllerB": prepareSceneB(segue)
            default: break
        }
    }
    
    func prepareSceneB(_ segue: UIStoryboardSegue) {
        guard let controllerB = segue.destination as? ViewControllerB else { return }
        controllerB.updatingData = dataLabel.text ?? "no text from B"
    }
}

// MARK: - Update With Protocol
extension ViewControllerA {
    
    func onDataUpdateWithDelegate(data: String) {
        updatingData = data
        updateLabel(with: data)
    }
}




