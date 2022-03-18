import UIKit

var greeting = "Hello, playground"

class wind {
    var val: Int = 0
    
    var prt: Void {
        print("Val: ", val)
    }
    func changeVal(fn: (inout Int) -> Void) {
        fn(&val)
    }
    func addVal(fn: (Int) -> Int ) {
        self.val = fn(val)
    }
}

var el = wind()
el.prt
el.changeVal(fn: {el in
    el += 20
    print("Here el=", el)
})
el.prt
el.addVal(fn: {el in
  return el + 200
})
el.prt
