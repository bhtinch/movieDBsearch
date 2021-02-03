//
//  MovieTableViewCell.swift
//  movieDBsearch
//
//  Created by Benjamin Tincher on 2/2/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UITextView!
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            updateViews(movie: movie)
        }
    }
    
    func updateViews(movie: Movie) {
        titleLabel.text = movie.title
        ratingLabel.text = "Rating: \(movie.vote_average)"
        overviewLabel.text = movie.overview
        
        do {
            let imageData = try Data(contentsOf: movie.imageURL)
            guard let image = UIImage(data: imageData) else { return }
            self.movieImageView.image = image
        } catch {
            print("Error loading image")
        }
    }
}
