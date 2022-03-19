//
//  Contact.swift
//  Contacts
//
//  Created by Евгений Макеев on 17.03.2022.
//

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
    private var storageKey = C.storageKey
    private var coder = ContactCoder()
    
    func load() -> [ContactProtocol]? {
        guard let data = storage.array(forKey: storageKey) as? [[String:String]] else { return nil }
        return coder.decode(from: data)
    }
    
    func save(contacts: [ContactProtocol]) {
        storage.set(coder.code(to: contacts), forKey: storageKey)
    }
    
}


