import UIKit
import Foundation

protocol ContactProtocol {
    var title: String { get set }
    var phone: String { get set }
}

protocol ContactStorageProtocol {
    func load() -> [ContactProtocol]?
    func save(contacts: [ContactProtocol])
}

struct Contact: ContactProtocol {
    var title: String
    var phone: String
}



class ContactStorage: ContactStorageProtocol {
    
    private var storage = UserDefaults.standard
    private var storageKey = "contacts"
    private var coder = ContactCoder()
    
    func load() -> [ContactProtocol]? {
        guard let data = storage.array(forKey: storageKey) as? [[String:String]] else { return nil }
        return coder.decode(data: data)
    }
    
    func save(contacts: [ContactProtocol]) {
        storage.set(coder.code(contacts: contacts), forKey: storageKey)
    }
    
}

class ContactCoder {
    
    enum ContactKey: String {
        case title
        case phone
    }
    
    func code(contacts: [ContactProtocol]) -> [[String: String]] {
        
        return contacts.reduce(into: [[String: String]](), {acc, el in
            acc.append([ContactKey.title.rawValue: el.title, ContactKey.phone.rawValue: el.phone])
        })
    }
    
    func decode(data: [[String: String]]) -> [ContactProtocol] {
        return data.reduce(into: [ContactProtocol](), {acc, el in
            acc.append(Contact(title: el[ContactKey.title.rawValue]!, phone: el[ContactKey.phone.rawValue]!))
        })
    }
}

var storage = ContactStorage()
var contacts = [Contact(title: "Elsa Hosk", phone: "8989877799"), Contact(title: "Gigi Hadid", phone: "90909090")]
//storage.save(contacts: contacts)
var newcont = storage.load()
print(newcont ?? "no value")
