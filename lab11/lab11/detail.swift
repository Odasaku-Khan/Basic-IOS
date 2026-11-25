import UIKit
import Foundation
class HeroDetailViewController: UIViewController {
    @IBOutlet weak var portraitImageView: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var powerstatsTitleLabel: UILabel!
    @IBOutlet weak var powerstatsValuesLabel: UILabel!
    @IBOutlet weak var appearanceTitleLabel: UILabel!
    @IBOutlet weak var appearanceValuesLabel: UILabel!
    @IBOutlet weak var biographyTitleLabel: UILabel!
    @IBOutlet weak var biographyValuesLabel: UILabel!
    var hero: Hero?
    
    private func configureLabels(with hero: Hero) {
        heroNameLabel.text = hero.name
        powerstatsTitleLabel.text = "Power Statistics"
        powerstatsValuesLabel.text = """
        Intelligence: \(stat(hero.powerstats.intelligence))
        Strength: \(stat(hero.powerstats.strength))
        Speed: \(stat(hero.powerstats.speed))
        Durability: \(stat(hero.powerstats.durability))
        Power: \(stat(hero.powerstats.power))
        Combat: \(stat(hero.powerstats.combat))
        """
        appearanceTitleLabel.text = "Appearance"
        appearanceValuesLabel.text = """
        Gender: \(readable(hero.appearance.gender))
        Race: \(readable(hero.appearance.race))
        Height: \(readable(hero.appearance.height?.last))
        Weight: \(readable(hero.appearance.weight?.last))
        """
        biographyTitleLabel.text = "Biography"

        biographyValuesLabel.text = """
        Full Name: \(readable(hero.biography.fullName))
        Publisher: \(readable(hero.biography.publisher))
        Alignment: \(readable(hero.biography.alignment))
        """
    }
    
    private func loadPortrait(for hero: Hero) {

        portraitImageView.contentMode = .scaleAspectFill
        portraitImageView.clipsToBounds = true
        portraitImageView.layer.cornerRadius = 12

        portraitImageView.image = UIImage(
            systemName: "person.crop.square"
        )

        guard let imageURL = hero.images.md
            ?? hero.images.lg
            ?? hero.images.sm
            ?? hero.images.xs else {
            return
        }

        HeroImageLoader.shared.loadImage(from: imageURL) {
            [weak self] image in

            guard let self = self,
                  self.hero?.id == hero.id else {
                return
            }

            if let image = image {
                self.portraitImageView.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let hero = hero else { return }

        navigationItem.title = hero.name

        configureLabels(with: hero)
        loadPortrait(for: hero)
    }
    private func stat(_ value: Int?) -> String {
        guard let value = value else {
            return "Unknown"
        }

        return "\(value)"
    }

    private func readable(_ value: String?) -> String {
        guard let value = value?
            .trimmingCharacters(in: .whitespacesAndNewlines),
              !value.isEmpty,
              value != "-",
              value.lowercased() != "null",
              value != "0 cm",
              value != "0 kg" else {
            return "Unknown"
        }

        return value
    }
}
