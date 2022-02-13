//
//  MainViewModel.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    let disposeBag = DisposeBag()
    
    let repoTableViewModel = RepoTableViewModel()
    
    let presentSearchAlert: Driver<Void>
    let searchButtonTapped = PublishRelay<Void>()
    
    let alertTextFieldText = PublishSubject<String?>()
    let alertSearchButtonTapped = PublishRelay<Void>()

    init(model: MainModel = MainModel()) {
        
        
        
        self.presentSearchAlert = searchButtonTapped
            .asDriver(onErrorDriveWith: .empty())
            
        let searchedText = alertTextFieldText

        let repoResult = Observable
            .combineLatest(
                searchedText,
                alertSearchButtonTapped
            )
            .flatMapLatest { (query, _) in
                return model.searchIssueInRepo(query ?? "")
            }
            .share()
        
        let repoValue = repoResult
//            .asObservable()
            .compactMap { data -> [RepoIssue]? in
                model.getIssueValue(data)
            }
        
        let repoError = repoResult
            .compactMap { data -> String? in
                model.getIssueError(data)
            }
        
        let cellData = repoValue
            .map { value -> [RepoIssueCellData] in
                model.getBlogListCellData(value)
            }
            
        cellData
            .bind(to: repoTableViewModel.repoCellData)
            .disposed(by: disposeBag)
    }
}
