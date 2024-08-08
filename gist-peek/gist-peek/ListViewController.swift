//
//  ListViewController.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit

class ListViewController: UIViewController {
    // MARK: - Component(s).
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        view.addSubview(tableView)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.scrollsToTop = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//     MARK: - Property(ies).
    var model: ListViewModel?
    var repositories: [Repository] {
        model?.repositories ?? []
    }
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista"
        view.backgroundColor = .white
        view.addSubview(mainView)
        configTableView()
        configConstraints()
        model?.load()
        setupAddConfiguration()
    }
    
    // MARK: - Method(s).
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
    }
    
    private func setupAddConfiguration() {
        emptyView.button.addTarget(self, action: #selector(reloading), for: .touchUpInside)
    }
    
    @objc private func reloading() {
        emptyView.button.backgroundColor = .gray
        model?.load()
    }
    
    private func setStateView() {
        if model?.repositories.isEmpty == true {
            mainView.bringSubviewToFront(emptyView)
        } else {
            mainView.bringSubviewToFront(tableView)
        }
    }
    
    // MARK: - UIConfigurable.
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: mainView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            emptyView.topAnchor.constraint(equalTo: mainView.topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
            
        ])
    }
}
// MARK: - Extension(s).
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if repositories.count - 1 == indexPath.row {
            self.model?.load()
            return makeLoadingCell(tableView, cellForRowAt: indexPath)
        }
        return makeListCell(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    private func makeListCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ListTableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier, for: indexPath
        ) as? ListTableViewCell else {
            fatalError()
        }
        let repository = repositories[indexPath.row]
        cell.configure(model: repository)
        return cell
    }
    
    private func makeLoadingCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if model?.isLoading == true {
            
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LoadingTableViewCell.identifier, for: indexPath
            ) as? LoadingTableViewCell else {
                fatalError()
            }
            return cell
        }
        
        return makeListCell(tableView, cellForRowAt: indexPath)
    }
}

extension ListViewController: ListViewModelDelegate {
    func didLoadSucess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setStateView()
        }
    }
    
    func didError(message: String) {
        DispatchQueue.main.async {
            print(message)
        }
    }
}
