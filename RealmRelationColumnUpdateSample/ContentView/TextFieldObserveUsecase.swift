//
//  TextFieldObserveUsecase.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Combine

class TextFieldObserveUsecase {
    
    private var viewModel: ContentViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
    }
    
    func execute() {
        
        viewModel.$id.combineLatest(viewModel.$message)
            .sink { id, message in
                
                if id > 0 && !message.isEmpty {
                    
                    self.viewModel.isDisabledCreateRecodeButton = false
                    return
                }
                
                self.viewModel.isDisabledCreateRecodeButton = true
            }
            .store(in: &cancellables)
    }
}
