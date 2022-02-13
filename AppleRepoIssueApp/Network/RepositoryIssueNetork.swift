//
//  RepositoryIssueNetork.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import Foundation
import RxSwift
import RxCocoa

enum RepositoryIssueNetorkError: Error {
    case invalidJSON
    case networkError
    case invalidURL
}

class RepositoryIssueNetork {
    private let session: URLSession
    let api = RepositoryIssueAPI()
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func searchIssue(query: String) -> Single<Result<[RepoIssue], RepositoryIssueNetorkError>> {
        
        guard let url = api.searchRepoIssue(query: query).url else {
            return .just(.failure(.invalidURL))
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        
        return session.rx.data(request: request as URLRequest)
            .map { data in
                do {
                    let blogData = try JSONDecoder().decode([RepoIssue].self,
                        from: data)
                    return .success(blogData)
                } catch {
                    return .failure(.invalidJSON)
                }
            }
            .catch { _ in
                .just(.failure(.networkError))
            }
            .asSingle()
    }
    
}
