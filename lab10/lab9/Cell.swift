import Foundation
import UIKit
class FavouriteCell: UITableViewCell {
    @IBOutlet weak var gameImageVieew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    func configure(with item: FavoriteItem ){
        titleLabel.text = item.title
        gameImageVieew.image = UIImage(named: item.imageName)
    }
}
