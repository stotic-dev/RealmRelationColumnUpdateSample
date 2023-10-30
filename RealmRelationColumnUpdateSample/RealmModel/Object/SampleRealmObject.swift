//
//  SampleRealmObject.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Foundation
import RealmSwift

class SampleRealmObject: BaseRealmObject {
    
    @Persisted(primaryKey: true) var id = UUID()
    @Persisted var relation: SampleColumnRelationObject?
    
    override var objectName: String {
        
        return "SampleRealmObject"
    }
    
    override class func primaryKey() -> String? {
        
        return "id"
    }
    
    func getInsertOrUpdateValue(colomunId: Int, message: String) -> [String: Any] {
        
        guard let sampleObjectPrimarykey = SampleRealmObject.primaryKey(),
              let recodeValue = [sampleObjectPrimarykey: id,
                                 "relation": SampleColumnRelationObject(id: colomunId, message: message)] as? [String: Any] else {

            print("Failed create recode object")
            return [:]
        }
        
        return recodeValue
    }
}
