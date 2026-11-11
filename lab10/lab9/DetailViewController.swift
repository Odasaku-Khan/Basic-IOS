import UIKit

class DetailViewController: UIViewController{
    var item: FavoriteItem?
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameDescriptionLabel: UILabel!
    @IBOutlet weak var gameSubtitle: UILabel!
    @IBOutlet var starsRaiting: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else {
            return
        }
        navigationItem.title = item.title
        gameImageView.image = UIImage(named: item.imageName)
        gameTitleLabel.text = item.title
        gameSubtitle.text = item.subtitle
        gameDescriptionLabel.text = item.description
        
        for star in starsRaiting{
            let symbol = star.tag < item.rating ? "star.fill" : "star"
            star.image = UIImage(systemName: symbol)
            star.tintColor = .systemCyan
        }
    }
}
