//
//  ContentView.swift
//  RealmRelationColumnUpdateSample
//
//  Created by 佐藤汰一 on 2023/10/29.
//

import Combine
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    private let observeSampleObjectUsecase: ObserveSampleObjectUsecase
    private let textFieldObserverUsecase: TextFieldObserveUsecase
    private let createRealmRecodeUsecase: CreateRealmRecodeUsecase
    private let updateRelationObjectUsecase: UpdateRelationObjectUsecase
    private let textFieldLeadingMargin: CGFloat = 10
    
    init(viewModel: ContentViewModel) {
        
        self.viewModel = viewModel
        observeSampleObjectUsecase = ObserveSampleObjectUsecase(viewModel: viewModel)
        textFieldObserverUsecase = TextFieldObserveUsecase(viewModel: viewModel)
        createRealmRecodeUsecase = CreateRealmRecodeUsecase(viewModel: viewModel)
        updateRelationObjectUsecase = UpdateRelationObjectUsecase()
    }
    
    var body: some View {
        VStack {
            HStack(spacing: textFieldLeadingMargin) {
                Text("ID")
                TextField("ID", value: $viewModel.id, format: .number)
                Stepper("", value: $viewModel.id)
            }
            HStack(spacing: textFieldLeadingMargin) {
                Text("Message")
                TextField("Message", text: $viewModel.message)
            }
            Button(action: {
                
                createRealmRecodeUsecase.execute(id: viewModel.id, message: viewModel.message)
            }, label: {
                Text("Create Recode")
            })
            .disabled(viewModel.isDisabledCreateRecodeButton)
            
            Divider()
            
            createRecodeList()
        }
        .padding()
        .onAppear {
            
            textFieldObserverUsecase.execute()
            observeSampleObjectUsecase.execute()
        }
        .onDisappear {
            
            observeSampleObjectUsecase.cancel()
        }
    }
    
    func createRecodeList() -> some View {
        
        List {
            ForEach(viewModel.recodeList, id: \.target.id) { recode in
                HStack {
                    Text(recode.target.id.uuidString)
                    Text(recode.message)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(action: {
                        updateRelationObjectUsecase.execute(target: recode.target, message: recode.message)
                    }, label: {
                        Text("Edit")
                    })
                    .tint(.yellow)
                }
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
