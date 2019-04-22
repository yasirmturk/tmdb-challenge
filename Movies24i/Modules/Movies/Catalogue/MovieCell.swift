//
//  MovieCell.swift
//  Movies24i
//
//  Created by Yasir M Turk on 21/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import RxSwift
import RxCocoa
import AlamofireImage

class MovieCell: RxTableCell {

    // MARK: - Outlets
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Fields
    static var reuseIdentifier = "MovieCell"

    // MARK: - Properties
    var viewModel: MovieCellViewModel! {
        didSet {
            viewModel.movie.subscribe(onNext: { [weak self] movie in
                self?.reloadData(movie)
            }).disposed(by: bag)
        }
    }

    override func prepareView() {
        super.prepareView()

        posterView.contentMode = .scaleAspectFill
        titleLabel.font = UIFont.systemFont(ofSize: 25)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        posterView.image = nil
        titleLabel.text = nil
    }

    func reloadData(_ movie: Movie) {
        titleLabel.text = movie.title
        if let poster = movie.posterURL() {
            posterView.af_setImage(withURL: poster, placeholderImage: UIImage(named: "mozima"))
        }
    }

}
