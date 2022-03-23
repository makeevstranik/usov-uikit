//
//  ViewControllerB.swift
//  Transfer
//
//  Created by Евгений Макеев on 21.03.2022.
//

import UIKit

class ViewControllerB: UIViewController {
    
    @IBOutlet weak var dataTextField: UITextField!
    
    var updatingData: String = ""
    
    weak var delegate: ViewControllerA!
    
    var completionClosure: ((String) -> Void)?
    
    deinit {
        print("From B Class: \(self.debugDescription) is nil")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = getControllerFromStack(titleA: "ControllerA") as? ViewControllerA
        print(delegate!)
        updateTextFieldData(with: updatingData)
    }
    
    @IBAction func changeAWithProperty(_ sender: UIButton) {
        let controllerA = getControllerFromStack(titleA: "ControllerA")
        controllerA.updatingData = dataTextField.text ?? "No data from A"
        navigationController?.popToViewController(controllerA, animated: true)
    }
    
    @IBAction func changeAByDelegate(_ sender: UIButton) {
        delegate.onDataUpdateWithDelegate(data: dataTextField.text ?? "no text from B by delegate")
        // go to previous controller
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeAByClosurePressed(_ sender: UIButton) {
        guard let closureFromA = completionClosure else {
            let alert = UIAlertController(title: "No Closure", message: "Set Closure In A", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        print("=+++++++++++++++++++++")
        closureFromA(dataTextField.text ?? "no text from B" )
        navigationController?.popViewController(animated: true)
    }
    
    private func updateTextFieldData(with text: String) {
        dataTextField.text = text
    }
    
    private func getControllerFromStack(titleA: String) -> TransferChangeableProtocol {
       return navigationController?.viewControllers.first(where: {$0.title == titleA}) as! TransferChangeableProtocol
    }
}

// MARK: - unwindSegueToA
extension ViewControllerB {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "unwindToControllerA": prepareSceneA(segue)
            default: break
        }
    }
    
    func prepareSceneA(_ segue: UIStoryboardSegue) {
        guard let controllerA = segue.destination as? ViewControllerA else { return }
        controllerA.updatingData = dataTextField.text ?? "no text from B"
    }
}

// MARK: - Update With Protocol
extension ViewControllerB: TransferChangeableProtocol {
    
    func onDataUpdateWithDelegate(data: String) {
        updatingData = data
        updateTextFieldData(with: data)
    }
}
