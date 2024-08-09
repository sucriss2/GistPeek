//
//  LoadingViewController.swift
//  gist-peek
//
//  Created by Suh on 09/08/24.
//

import UIKit

final class LoadingViewController: UIViewController {

    // MARK: - Component(s).
    private let viewLoading: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .lightGray
        view.alpha = 0.8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.startAnimating()
        view.color = .red
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initialization.
    init() {
        super.init(nibName: nil, bundle: nil)
        buidViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
    }

    // MARK: - UIConfigurable.
    func buidViewHierarchy() {
        containerView.addSubview(loadingIndicator)
        viewLoading.addSubview(containerView)
        view.addSubview(viewLoading)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewLoading.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewLoading.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewLoading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewLoading.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 150),
            containerView.widthAnchor.constraint(equalToConstant: 150),

            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
