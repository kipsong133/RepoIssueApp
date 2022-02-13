//
//  RepoTableViewCell.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import UIKit
import SnapKit

class RepoTableViewCell: UITableViewCell {
    static let identifier = "RepoTableViewCell"
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // DataFlow: vc -> tv -> cell
    public func setupData() {
        
    }
    
    private func setupAttribute() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        titleLabel.textColor = .black
    }
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
