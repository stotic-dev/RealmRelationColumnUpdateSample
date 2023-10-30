//
//  MessageObject.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import RealmSwift

class SampleColumnRelationObject: BaseRealmObject {
    
    @Persisted var id: Int
    @Persisted var message: String
    
    override var objectName: String {
        
        return "SampleColumnRelationObject"
    }
    
    override class func primaryKey() -> String? {
        
        return "id"
    }
    
    convenience init(id: Int, message: String) {
        
        self.init()
        
        self.id = id
        self.message = message
    }
}
