import Foundation

protocol MessageProtocol {
    var text: String? { get set }
    var image: Data? { get set }
    var audio: Data? { get set }
    var video: Data? { get set }
    var sendDate: Date { get set }
    var senderID: UInt { get set }
}

protocol StatisticDelegateProtocol {
    func handle(message: MessageProtocol)
}

protocol MessengerProtocol {
    var messages: [MessageProtocol] { get set }
    var statisticDelegate: StatisticDelegateProtocol? { get set }
    var dataSourceDelegate: DataSourceDelegateProtocol? { get set }
    
    init()
    
    mutating func receiveMessage(message: MessageProtocol)
    mutating func sendMessage(message: MessageProtocol)
}

protocol DataSourceDelegateProtocol {
    func getMessages() -> [MessageProtocol]
}

struct Message: MessageProtocol {
    var text: String?
    var image: Data?
    var audio: Data?
    var video: Data?
    var sendDate: Date
    var senderID: UInt
}

class StatisticManager: StatisticDelegateProtocol {
    func handle(message: MessageProtocol) {
        // work with message
        print("Message from sender #\(message.senderID)# has completed" )
    }
}

class DataSource: DataSourceDelegateProtocol {
    func getMessages() -> [MessageProtocol] {
        [Message(text: "From DB", image: nil, audio: nil, video: nil, sendDate: Date(), senderID: 2)]
    }
}

class Messenger: MessengerProtocol {
    var messages: [MessageProtocol]
    
    // delegate pattern
    var statisticDelegate: StatisticDelegateProtocol?
    
    // source delegate pattern
    var dataSourceDelegate: DataSourceDelegateProtocol? {
        // update all data if delegate has been changed
        didSet {
            if let source = dataSourceDelegate {
                messages = source.getMessages()
                
            }
        }
    }
    required init() {
        messages = []
    }
    
    func receiveMessage(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // receive message
    }
    
    func sendMessage(message: MessageProtocol) {
        statisticDelegate?.handle(message: message)
        messages.append(message)
        // send message
    }
}


var messenger = Messenger()
messenger.statisticDelegate = StatisticManager()
messenger.dataSourceDelegate = DataSource()
messenger.sendMessage(message: Message(text: "Hello", image: nil, audio: nil, video: nil, sendDate: Date(), senderID: 1))

// ===== self as a Delegate realization ======
// link to Delegate in Messenger must be weak

//extension Messenger: StatisticDelegateProtocol {
//    func handle(message: MessageProtocol) {
//        // work with message
//        print("Message from sender #\(message.senderID)# has completed in Messenger" )
//    }
//}
//
//var messenger2 = Messenger()
//messenger2.statisticDelegate = messenger2.self
//messenger2.sendMessage(message: Message(text: "Hello-Helo", image: nil, audio: nil, video: nil, sendDate: Date(), senderID: 2))
//
//print(messenger2.messages)
//print((messenger2.statisticDelegate as! Messenger).messages)

print(messenger.messages)
print((messenger.dataSourceDelegate?.getMessages())!)

messenger.dataSourceDelegate = DataSource()
// self.[massages] have replaced 
print("----------------")
print(messenger.messages)
