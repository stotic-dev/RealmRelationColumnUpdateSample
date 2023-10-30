//
//  CreateRealmRecodeUsecase.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Foundation

struct CreateRealmRecodeUsecase {
    
    private var viewModel: ContentViewModel
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
    }
    
    func execute(id: Int, message: String) {
        
        let isSuccess = RealmAccessor().insertOrUpdate(type: SampleRealmObject.self, value: SampleRealmObject().getInsertOrUpdateValue(colomunId: id, message: message))
        checkResult(isSuccess: isSuccess)
        
        resetTextField()
    }
}

private extension CreateRealmRecodeUsecase {
    
    func checkResult(isSuccess: Bool) {
        
        if isSuccess {
            
            print("Success create recode")
            for recode in RealmAccessor().read(type: SampleRealmObject.self) {
                
                recode.printDebugInfo()
            }
            return
        }
        
        print("Failed create recode")
    }
    
    func resetTextField() {
        
        viewModel.id += 1
        viewModel.message = ""
    }
}
