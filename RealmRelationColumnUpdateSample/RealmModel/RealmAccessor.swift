//
//  RealmAccessor.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import RealmSwift

struct RealmAccessor {
    
    private let realm: Realm?
    
    init() {
        
        self.realm = try? Realm()
    }
    
    func read<T>(type: T.Type) -> [T] where T: Object {
        
        guard let result = realm?.objects(type) else { return Array<T>() }
        return Array(result)
    }
    
    func insertOrUpdate<T>(type: T.Type, value: [String: Any]) -> Bool where T: Object {
        
        return writeBlock {
            
            realm?.create(type, value: value, update: .modified)
        }
    }
    
    func observeobjects<T>(type: T.Type, observeUpdateBlock: @escaping ([T]) -> Void) -> NotificationToken? where T: Object {
        
        let result = realm?.objects(type)
        return result?.observe({ change in
            
            if case .update(let updateResult, _, _, _) = change {
                
                observeUpdateBlock(Array(updateResult))
            }
        })
    }
}

private extension RealmAccessor {
    
    func writeBlock(operation: @escaping () -> Void) -> Bool {
        
        do {
            
            try realm?.write(operation)
            return true
        }
        catch {
            
            errorAction(error: error)
            return false
        }
    }
    
    func errorAction(error: Error) {
        
        print("Occured realm error: \(error)")
    }
}
