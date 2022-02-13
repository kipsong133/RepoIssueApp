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
    
    let alertTextFieldText = PublishRelay<String?>()
    let alertSearchButtonTapped = PublishRelay<Void>()
    
    let itemSelected = PublishRelay<Int>()
    let push: Driver<DetailViewModel>

    init(model: MainModel = MainModel()) {
        var detailViewModel = DetailViewModel()
        
        self.presentSearchAlert = searchButtonTapped
            .asDriver(onErrorDriveWith: .empty())
            
        let repoResult = alertSearchButtonTapped
            .withLatestFrom(alertTextFieldText)
            .flatMapLatest ({ query -> Single< Result<[RepoIssue], RepositoryIssueNetorkError>> in
                return model.searchIssueInRepo(query ?? "apple/swift")
            })
            .share()
        
        let repoValue = repoResult
            .compactMap { data -> [RepoIssue]? in
                model.getIssueValue(data)
            }
        
        // error
        _ = repoResult
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
        
        
        
        self.push = itemSelected
            .compactMap{ row -> DetailViewModel? in
                guard row != 4 else { return nil }
                return detailViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
