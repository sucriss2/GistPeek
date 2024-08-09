//
//  DetailView.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import UIKit

final class DetailView: UIView {
    // MARK: - Component(s).
    lazy var imageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: "github-icon")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome do Usuario"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
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
    var name: String? {
        didSet {
            nameLabel.text = name ?? String()
        }
    }
    
    // MARK: - Initialization.
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        buidViewHierarchy()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIConfigurable.
    private func buidViewHierarchy() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameLabel)
        self.addSubview(stackView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.heightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
