//
//  DetailViewController.swift
//  gist-peek
//
//  Created by Suh on 08/08/24.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    var screen: DetailView?
    var model: DetailModel?
    
    // MARK: - Override(s).
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes do Gist"
        view.backgroundColor = .purple
        view = screen
        setupDetail()
    }
    
    private func setupDetail() {
        guard let model = model else {
            return
        }
        screen?.name = model.name
        let url = URL(string: model.image)
        screen?.imageView.kf.setImage(with: url)
    }
}
