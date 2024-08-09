//
//  ListTableViewCell.swift
//  gist-peek
//
//  Created by Suh on 05/08/24.
//

import UIKit
import Kingfisher

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"

    // MARK: - Component(s).
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

    lazy var filesCount: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    lazy var labelStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 4
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let cellStackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 16
        view.isLayoutMarginsRelativeArrangement = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Property(ies).
    private let placeholder = UIImage(named: "github-icon")

    // MARK: - Override(s).
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellStackView.addArrangedSubview(photoImageView)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(filesCount)
        cellStackView.addArrangedSubview(labelStackView)
        contentView.addSubview(cellStackView)
        configConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        photoImageView.image = nil
        filesCount.text = nil
    }

    // MARK: - UIConfigurable.
    public func configure(model: Repository) {
        nameLabel.text = model.ownerLogin
        filesCount.text = String("\(model.filesCount) Arquivo(s)")
        let url = URL(string: model.ownerAvatarUrl)
        photoImageView.kf.setImage(with: url, placeholder: placeholder)
    }

    private func configConstraints() {
        photoImageView.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true

        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: self.topAnchor),
            cellStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
