//
//  HellobotCell.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import SnapKit
import Kingfisher
import UIKit

class HellobotCell: UITableViewCell {
    static let identifier = "HellobotCell"
    
    let cellImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupAttribute() {
        cellImageView.contentMode = .scaleAspectFit
        cellImageView.kf.setImage(with: URL(string: "https://s3.ap-northeast-2.amazonaws.com/hellobot-kr-test/image/main_logo.png")!, placeholder: UIImage(systemName: "photo"))
        self.selectionStyle = .none
    }
    
    private func setupLayout() {
        contentView.addSubview(cellImageView)
        cellImageView.snp.makeConstraints {
            $0.top.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(80)
            
        }
    }
}

