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
        view.addSubview(errorConection)
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.scrollsToTop = true
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var emptyView: StatusView = {
        let view = StatusView(config: StatusView.Config(title: "Não há nada aqui", textInfo: "sua lista de coleção está vazia", buttonTitle: "Atualizar"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorConection: StatusView = {
        let config = StatusView.Config(title: "Erro na conexão", textInfo: "Verifique sua rede e tente novamente", image: UIImage(named: "error-connection"), buttonTitle: "Recarregar")
        let view = StatusView(config: config)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.backgroundColor = .white
        view.addSubview(mainView)
        configTableView()
        configConstraints()
        model?.load()
        emptyView.delegate = self
        errorConection.delegate = self
    }
    
    // MARK: - Method(s).
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.identifier)
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
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.lineToViewBorder(view: mainView)
        emptyView.lineToViewBorder(view: mainView)
        errorConection.lineToViewBorder(view: mainView)
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
            self.mainView.bringSubviewToFront(self.errorConection)
            print(message)
        }
    }
}

extension UIView {
    func lineToViewBorder(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListViewController: StatusViewDelegate {
    func didReloadView() {
        DispatchQueue.main.async {
            self.model?.load()
        }
    }
}
