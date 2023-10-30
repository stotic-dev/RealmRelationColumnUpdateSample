//
//  ContentViewModel.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    @Published var id = 0
    @Published var message = ""
    @Published var isDisabledCreateRecodeButton = true
    @Published var recodeList = [ContentRecodeInfo]()
}

class ContentRecodeInfo: ObservableObject {
    
    @Published var message: String
    var target: SampleRealmObject
    
    init(message: String, target: SampleRealmObject) {
        
        self.message = message
        self.target = target
    }
}
