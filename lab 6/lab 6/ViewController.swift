import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    var curindex = -1
    func showFavourite(index: Int) {
        let game = favourites[index]
        titleLabel.text = game.title
        descriptionLabel.text = game.description
        companyLabel.text = game.company
        yearLabel.text = game.dateOfRelese
        gameImage.image = UIImage(named: game.image)
        
    }
    @IBAction func next(_ sender: UIButton) {
        var random = Int.random(in: 0..<favourites.count)
        while curindex == random {
            random = Int.random(in: 0..<favourites.count)
        }
        curindex = random
        showFavourite(index: random)
        sender.setTitle("Next", for: .normal)
    }
    func defaultScreen(){
        titleLabel.text = "Press Start to see a random game"
        descriptionLabel.text = "This is a simple app for showning my personal favourte game"
        companyLabel.text = "list limited to 10 games."
        yearLabel.text = "2026"
        gameImage.image = UIImage(named: "default")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let elements: [UIView] = [
            gameImage,
            titleLabel,
            descriptionLabel,
            companyLabel,
            yearLabel,
        ]

        for element in elements {
            element.alpha = 0
        }

        for (index, element) in elements.enumerated() {
            UIView.animate(
                withDuration: 0.5,
                delay: Double(index) * 0.12
            ) {
                element.alpha = 1
            }
        }
    }


}

