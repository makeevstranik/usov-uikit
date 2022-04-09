# usov-uikit
Practice from book:

#### *Усов В. Swift. Разработка приложений под iOS на основе фреймворка UIKit. 2021* ####
[Book Site](https://swiftme.ru/)
---
## Structure: ## 

### App Name ### 
> app name 
### Description ###
> App description
### Notes ###
> my notes, some code examples

**#1**

> Commit tag  
---
## LIST OF COMMITTED FILES GOES FROM HERE: ⬇️ ##
---
### Right On Target ### 
App life cycle, scene, navigation, AppDelegate, SceneDelegate, MVC, generics, protocols

#### 📓 Notes ####
❗ Tree ways to change the scene 
- Segues (cose scene overloading)
- Present, Dismiss methods (see p.83) 
- Navigation Controller

❗ Life Cycle

![life cycle](readme-images/life-cycle.png)

**commit #1**

---
### Contacts ###
App for saving contacts (title and phone), it's possible to create or change a contact or delete it. 

Using: 
- User Defaults - (save *struct with self-made coding/decoding to appropriate UD type 
  + 🖕 DON'T DO THAT, as UD only for simple types and data)
  + 🖕 Pay attention: There is far more simple way to code/decode *struct* (conform protocol *Codable*) but it doesn't work with *protocol* only for library      types
    [see here](https://stackoverflow.com/questions/50346052/protocol-extending-encodable-or-codable-does-not-conform-to-it#fromHistory), 
    [and here](https://stackoverflow.com/questions/46337380/conforming-class-to-codable-protocol-in-swift4)
   
- Table View - (reusable cell)
- ToolBar - (add new item)
- Polimorfism with *prortocols*
- Swipe in cell - (*trailingSwipeActionsConfigurationForRowAt* call Alert) 
- Alert - the same allert for adding and changing contacts

**commit #2**
---
### Navigation ###
Sample App - to find out how navigation works.  
Using: 
- Navigation Controller (❗there is only one  ViewController for working with 3 scenes DON'T DO THAT)
- Create UIView Controller by code from UIStoryboard by storyboardID
- Navigation Stack (DON'T create the same UIView Controller instances in N.Stack, for not consequently moving).   
  check there is't *-green-* instance in stack:   
  
  ```swift
    // -green- controller is already in stack
    // self.navigationController?.pushViewController(nextViewController, animated: true) WILL CREATE 
    // SECOND -green- nextViewController
    @IBAction func toGreenFromYellowPressed(_ sender: UIButton) {
        guard let controllers = self.navigationController?.viewControllers else { return }
        // avoid making the same instances in Nav. stack
        for controller in controllers {
            if controller.title == "-green-" {
                self.navigationController?.popToViewController(controller, animated: true)
                break
            }
        }
    }
  ```
  - change root scene:   
```swift
self.navigationController?.viewControllers[0] = someViewController
```
---
### Transfer ###
This app is just example of transferring data between controllers!!!
Read comments in code! 
Use PROTOCOLS for polymorphism!
Use NavigationController
Using:   
Four ways to transfer data from A --> B, B --> A (Any --> Any)
1. By property 
    #### A --> B ####
    + make *var updatingData* in B 
    + make *func updateSomeFieldWithData(updatingData)* in B - WillAppear
    + take instance B in A by storyBoardId
    ``` swift
    private func getController(storyboardId: String) -> TransferChangeableProtocol {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! TransferChangeableProtocol
    }
    ```
    + change B.updatingData in A
    + go to B 
    ``` swift
    self.navigationController?.pushViewController(controllerB, animated: true)
    ```
2. By segue
  #### A --> B ####
  + connect Action Button in A with B by segue (show method)
  + change segue's Identifier (toControllerB)
  + make *prepare* method in A (change updatingData in B instance)
```swift
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
```
   #### forward Any --> back Any #### unwind Segue (B --> A)
   + make in A 
 ```swift
 @IBAction func unwindToControllerA(_ segue: UIStoryboardSegue) {
        // doesn't need to be coded!!!!!
        // this func will automatically appear in case of connection view from controllerB and top icon /Exit/
    }
 ```
  + connect Action Button in B with *Exit* element in B and chose *unwindToControllerA*
  + change segue identifier *unwindToControllerA* 
  + make prepare method in B (change updatingData in A  see above ⬆️)
  
3. By delegate (use *protocol*)
- make ChangeableProtocol with func updatingData()
- make var *delegateB!: ChangeableProtocol* in A
- take instance B (or get from stack in back movement)

``` delegateB = getController(storyboardId: "SecondViewController") as? ViewControllerB ```

- change B  ``` delegateB.updatingData() ```

4. By closure. 
#### A --> B --> A 
- set closure handler in B
- set closure in Action in A to instance B (taken as above)
```swift
@IBAction func setClosureInBPressed(_ sender: UIButton) {
        delegateB.completionClosure = { [unowned self] updateValue in
            self.textFieldA.text = updateValue
        }
}
```
- call closure handler in B with new data (change data in A)

REMEMBER:   
- moving forward  A->B create new instance of B
- moving back to Any (A) take A instance from NavigationController Stack:
``` swift
 private func getControllerFromStack(titleA: String) -> TransferChangeableProtocol {
       return navigationController?.viewControllers.first(where: {$0.title == titleA}) as! TransferChangeableProtocol
    }
 ```
 - moving just to previous controller B->A, C->B
 ```swift
 navigationController?.popViewController(animated: true)
 ```  
 **commit #4**
 
 ---   
 ### ToDoManager ###
 App for saving and changing tasks. 3 screens.
 using:
 - Xib Cell
 - User Defaults (saving codable class with JsonCoder)
 - Table View 
 - Static Cells
 - Segue, Closure, Delegate transfer data between controllers
 - Original book app structure, is changed. Controller and Model strictly detached. All interaction through TaskManager and TaskStorage.
 - New sorting algorithm is aded (sort only current section data).
 - All description text for tasks is using with help of corresponding enum methods
 
  **commit #5.1**
  ---
  
 
