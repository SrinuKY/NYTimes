//
//  ArticlesTableViewCell.swift
//  NY Times
//
//  Created by Srinu K on 23/09/23.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateList(article:Article) {
        self.titleLabel.text = article.title        
        self.titleLabel.text = article.title
        self.subTitleLabel.text = article.articleDescription
        self.authorLabel.text = article.author
        self.dateLabel.text = Helper().convertDateFormateString(date: article.publishedAt ?? "")
        let imgURL = article.urlToImage ?? ""
        self.mediaImageView.imageFromURL(urlString: imgURL)
    }

}
