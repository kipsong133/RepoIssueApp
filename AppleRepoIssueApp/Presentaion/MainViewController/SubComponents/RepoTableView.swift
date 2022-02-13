//
//  RepoTableView.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import UIKit
import RxSwift
import RxCocoa

class RepoTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: RepoTableViewModel) {
        
    }
    
    private func setupAttribute() {
        self.tableFooterView = UIView()
        self.backgroundColor = .white
    }
    
    private func setupLayout() {
        
    }
}
