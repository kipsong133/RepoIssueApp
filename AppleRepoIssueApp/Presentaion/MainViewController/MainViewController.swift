//
//  MainViewController.swift
//  AppleRepoIssueApp
//
//  Created by 김우성 on 2022/02/13.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    
    let repoTableView = RepoTableView()
    let searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.setTitle("Search", for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        searchButton.setTitleColor(.systemBlue, for: .normal)
        return searchButton
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupNavigation()
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(_ viewModel: MainViewModel) {
        
        searchButton.rx.tap
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
//        viewModel.presentSearchAlert
//            .emit(to: self.rx.setAlert)
//            .disposed(by: disposeBag)
        viewModel.presentSearchAlert
            .drive(onNext: {
                let alertController = UIAlertController(
                    title: "Search",
                    message: "원하시는 Repository를 입력해주세요.\nex) apple/swift",
                    preferredStyle: .alert)
                alertController.addTextField { tf in
                    tf.rx.text
                        .bind(to: viewModel.alertTextFieldText)
                        .disposed(by: self.disposeBag)
                }
                let action = UIAlertAction(
                    title: "확인",
                    style: .cancel){ action in
                        action.rx.deallocated
                            .bind(to: viewModel.alertSearchButtonTapped)
                            .disposed(by: self.disposeBag)
                            
                    }
                alertController.addAction(action)
                self.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
        
        
        
    }
    
    private func setupNavigation() {
        title = "Repo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.searchButton)
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        view.addSubview(repoTableView)
        repoTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

//typealias Alert = (title: String, message: String?)
//extension Reactive where Base: MainViewController {
//    var setAlert: Binder<String> {
//        return Binder(base) { base, data in
//            let alertController = UIAlertController(
//                title: data,
//                message: "원하시는 Repository를 입력해주세요.",
//                preferredStyle: .alert)
//            let action = UIAlertAction(
//                title: "확인",
//                style: .cancel,
//                handler: nil)
//            alertController.addTextField { _ in }
//            alertController.addAction(action)
//            alertController.textFields[0].rx.text
//                .bind(to: <#T##String?...##String?#>)
//            base.present(alertController, animated: true)
//        }
//    }
//}
