import Foundation
import UIKit
class FavouriteCell: UITableViewCell {
    @IBOutlet weak var gameImageVieew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet var stars: [UIImageView]!
    func updateRaiting(_raiting: Int){
        for star in stars{
            let symbol = star.tag < _raiting ? "star.fill" : "star"
            star.image = UIImage(systemName: symbol)
        }
    }
    func configure(with item: FavoriteItem ){
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        gameImageVieew.image = UIImage(named: item.imageName)
        for star in stars {
            let symbol = star.tag < item.rating ? "star.fill" : "star"
            star.image = UIImage(systemName: symbol)
            star.tintColor = .systemBlue
            
        }
    }
}
