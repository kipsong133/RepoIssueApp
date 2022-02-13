//
//  DetailViewController.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import SnapKit
import UIKit


class DetailViewController: UIViewController {
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let usernameLabel = UILabel()
    let userProfileImage = UIImageView()
    let contentLabel = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupAttriute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAttriute() {
        view.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        usernameLabel.text = "유저이름"
        contentLabel.text = "content"
    }
    
    private func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(contentLabel)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        [usernameLabel, contentLabel].forEach{ stackView.addArrangedSubview($0) }
    }
}
