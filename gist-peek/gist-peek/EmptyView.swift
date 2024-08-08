//
//  EmptyView.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import Foundation
import UIKit

final class EmptyView: UIView {
    // MARK: - Component(s).
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nào há nada aqui"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "sua lista de coleção está vazia"
        label.textColor = .lightGray
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "empty")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization.
    init() {
        super.init(frame: .zero)
        buidViewHierarchy()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    private func buidViewHierarchy() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(textLabel)
        mainView.addSubview(stackView)
        addSubview(mainView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: mainView.heightAnchor),
            
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            mainView.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
