import UIKit

class HeroCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var genderImage: UIImageView!

    private var imageTask: URLSessionDataTask?
    private var currentImageURL: String?

    func configure(with hero: Hero) {

        titleLabel.text = hero.name

        // MARK: Gender
        switch hero.appearance.gender?.lowercased() {

        case "male":
            genderImage.image = UIImage(systemName: "m.circle.fill")
            genderImage.tintColor = .systemBlue

        case "female":
            genderImage.image = UIImage(systemName: "f.circle.fill")
            genderImage.tintColor = .systemPink

        default:
            genderImage.image = UIImage(
                systemName: "questionmark.circle.fill"
            )
            genderImage.tintColor = .systemGray
        }

        // MARK: Portrait
        heroImage.image = UIImage(
            systemName: "person.crop.square"
        )

        heroImage.contentMode = .scaleAspectFill
        heroImage.clipsToBounds = true
        heroImage.layer.cornerRadius = 8

        guard let urlString = hero.images.sm ?? hero.images.xs else {
            currentImageURL = nil
            return
        }

        currentImageURL = urlString

        imageTask = HeroImageLoader.shared.loadImage(
            from: urlString
        ) { [weak self] image in

            guard let self = self,
                  self.currentImageURL == urlString else {
                return
            }

            if let image = image {
                self.heroImage.image = image
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil

        titleLabel.text = nil
        heroImage.image = UIImage(
            systemName: "person.crop.square"
        )
        genderImage.image = nil
    }
}
