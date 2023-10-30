//
//  BaseRealmObject.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Foundation
import RealmSwift

class BaseRealmObject: Object {
    
    @Persisted var createdAt = Date()
    
    var objectName: String {
        
        return "BaseRealmObject"
    }
    
    func printDebugInfo() {
        
        print("realm objectName:\(objectName), \(self)")
    }
}
