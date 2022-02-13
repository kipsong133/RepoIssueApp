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
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: RepoTableViewModel) {
        viewModel.cellData
            .drive(self.rx.items) { tv, row, data in
                let index = IndexPath(row: row, section: 0)
                
                if index.row == 4 {
                    guard let cell = tv.dequeueReusableCell(
                        withIdentifier: HellobotCell.identifier,
                        for: index) as? HellobotCell else { return UITableViewCell() }
//                    cell.setupData(data)
                    return cell
                }
                
                guard let cell = tv.dequeueReusableCell(
                    withIdentifier: RepoTableViewCell.identifier,
                    for: index) as? RepoTableViewCell else { return UITableViewCell() }
                cell.setupData(data)
                return cell
                
            }
            .disposed(by: disposeBag)
    }
    
    private func setupAttribute() {
        self.tableFooterView = UIView()
        self.backgroundColor = .white
        self.register(RepoTableViewCell.self,
                      forCellReuseIdentifier: RepoTableViewCell.identifier)
        self.register(
            HellobotCell.self,
            forCellReuseIdentifier: HellobotCell.identifier)
        self.rowHeight = UITableView.automaticDimension
    }
    
    private func setupLayout() {
        
    }
}
