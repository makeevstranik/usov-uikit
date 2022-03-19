//
//  ContactCoder.swift
//  Contacts
//
//  Created by Евгений Макеев on 19.03.2022.
//

import Foundation

class ContactCoder {
    
    let titleKey = C.ContactKey.title.rawValue
    let phoneKey = C.ContactKey.phone.rawValue
    
    func code(to contacts: [ContactProtocol]) -> [[String: String]] {
        
        return contacts.reduce(into: [[String: String]](), {acc, el in
            acc.append([titleKey: el.title, phoneKey: el.phone])
        })
    }
    
    func decode(from data: [[String: String]]) -> [ContactProtocol] {
        
        return data.reduce(into: [ContactProtocol](), {acc, el in
            acc.append(Contact(title: el[titleKey]!, phone: el[phoneKey]!))
        })
    }
    
}
