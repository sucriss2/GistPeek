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
    
    // MARK: - Property(ies).
    var model: ListViewModel?
    var repositories: [Repository] {
        model?.repositories ?? []
    }

    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista"
        view.backgroundColor = .cyan
        view.addSubview(mainView)
        configTableView()
        configConstraints()
        model?.load()
    }
    
    // MARK: - Method(s).
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
    }
    
    // MARK: - UIConfigurable.
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: mainView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
// MARK: - Extension(s).
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier, for: indexPath
        ) as? ListTableViewCell else {
            fatalError()
        }
        let repository = repositories[indexPath.row]
        cell.configure(model: repository)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ListViewController: ListViewModelDelegate {
    func didLoadSucess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didError(message: String) {
        DispatchQueue.main.async {
            print(message)
        }
    }
}
