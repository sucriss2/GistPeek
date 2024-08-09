//
//  StatusView.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import Foundation
import UIKit

protocol StatusViewDelegate: AnyObject {
    func didReloadView()
}

final class StatusView: UIView {
    
    struct Config {
        let title: String
        let textInfo: String
        var image = UIImage(named: "empty")
        let buttonTitle: String
    }
    
    // MARK: - Component(s).
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = config.title
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = config.textInfo
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = config.image
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var reloadButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.backgroundColor = .red
        view.layer.cornerRadius = 8.0
        view.setAttributedTitle(
            NSAttributedString(
                string: config.buttonTitle,
                attributes: [
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0),
                    NSAttributedString.Key.foregroundColor: UIColor.white
                ]
            ),
            for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addAction(UIAction { [weak self] _ in
            self?.delegate?.didReloadView()
        }, for: .touchUpInside)
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fill
        view.axis = .vertical
        view.alignment = .center
        view.spacing = 8
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 120, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Property(ies).
    let config: Config
    weak var delegate: StatusViewDelegate?
    
    // MARK: - Initialization.
    init(config: Config) {
        self.config = config
        super.init(frame: .zero)
        buidViewHierarchy()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIConfigurable.
    private func buidViewHierarchy() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(reloadButton)
        mainView.addSubview(stackView)
        addSubview(mainView)
    }
    
    private func configConstraints() {
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: mainView.heightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            reloadButton.heightAnchor.constraint(equalToConstant: 44),
            reloadButton.widthAnchor.constraint(equalToConstant: 120),
            
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
            
        ])
    }
}
