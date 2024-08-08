//
//  LoadingTableViewCell.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import Foundation
import UIKit

final class LoadingTableViewCell: UITableViewCell {
    // MARK: - Property(ies).
    static let identifier = "LoadingTableViewCell"
    
    // MARK: - Component(s).
    private let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .red
        view.style = .medium
        view.isHidden = false
        view.startAnimating()
        return view
    }()
    
    // MARK: - Override(s).
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainView.addSubview(spinner)
        contentView.addSubview(mainView)
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method(s).
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: mainView.centerYAnchor)
        ])
    }
}
