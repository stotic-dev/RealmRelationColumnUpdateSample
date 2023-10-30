//
//  UpdateRelationObjectUsecase.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/30.
//

struct UpdateRelationObjectUsecase {
    
    func execute(target: SampleRealmObject, message: String) {
        
        guard let colomunId = target.relation?.id else { return }
        let isSuccess = RealmAccessor().insertOrUpdate(type: SampleRealmObject.self, value: target.getInsertOrUpdateValue(colomunId: colomunId, message: message))
        checkResult(isSuccess: isSuccess)
    }
}

private extension UpdateRelationObjectUsecase {
    
    func checkResult(isSuccess: Bool) {
        
        if isSuccess {
            
            print("Success update recode")
            for recode in RealmAccessor().read(type: SampleRealmObject.self) {
                
                recode.printDebugInfo()
            }
            return
        }
        
        print("Failed upadte recode")
    }
}
