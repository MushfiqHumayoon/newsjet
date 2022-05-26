//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit

class ArticleCell: UITableViewCell {
// MARK: - Outlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var brief: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupThumbImageView()
        
    }
// MARK: - Subview setups
    func setupThumbImageView() {
        thumbnail.layer.cornerRadius = 20
        thumbnail.layer.masksToBounds = true
    }
// MARK: - Load data
    func setContent(with article: Article) {
        title.text = article.title
        brief.text = article.description
        author.text = article.author
        let dummyImage = UIImage(named: "dummyImage", in: Bundle.main, compatibleWith: .none)
        thumbnail.loadFrom(article.urlToImage, placeHolder: dummyImage)
    }
}
