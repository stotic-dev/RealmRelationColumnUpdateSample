//
//  ObserveSampleObjectUsecase.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/30.
//

import RealmSwift

class ObserveSampleObjectUsecase {
    
    private var viewModel: ContentViewModel
    private var notificationToken: NotificationToken?
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
    }
    
    func execute() {
        
        notificationToken = RealmAccessor().observeobjects(type: SampleRealmObject.self) { [weak self] updatedResult in
            
            guard let self = self else { return }
            self.viewModel.recodeList = updatedResult.map { recode in
                
                guard let message = recode.relation?.message else { return nil }
                return ContentRecodeInfo(message: message, target: recode)
            }
            .compactMap { $0 }
        }
    }
    
    func cancel() {
        
        notificationToken?.invalidate()
    }
}
