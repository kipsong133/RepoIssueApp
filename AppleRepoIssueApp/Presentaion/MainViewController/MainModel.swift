//
//  MainModel.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import Foundation
import RxCocoa
import RxSwift

struct MainModel {
//    typealias Response = Result<[RepoIssue], RepositoryIssueNetorkError>
    
    let network = RepositoryIssueNetork()
    
    func searchIssueInRepo(_ query: String) -> Single< Result<[RepoIssue], RepositoryIssueNetorkError>> {
        print("DEBUG: TextField입력값", query)
        return network.searchIssue(query: query)
    }
    
    func getIssueValue(_ result:  Result<[RepoIssue], RepositoryIssueNetorkError>) -> [RepoIssue]? {
        guard case .success(let value) = result else {
            return nil
        }
        return value
    }
    
    func getIssueError(_ result:  Result<[RepoIssue], RepositoryIssueNetorkError>) -> String? {
        guard case .failure(let error) = result else {
            return nil
        }
        return error.localizedDescription
    }
    
    func getBlogListCellData(_ value: [RepoIssue]) -> [RepoIssueCellData] {
        return value.map { response in
            let imageURL = URL(string: response.user?.imageURL ?? "")
            let issueURL = URL(string: response.url ?? "")
            return RepoIssueCellData(
                title: response.title ?? "",
                author: response.user?.username ?? "",
                url: issueURL,
                profileImageURL: imageURL,
                number: response.number)
        }
    }
}
