import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    private let heroService = HeroService()
    private var heroes: [Hero] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Heroes"

        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80

        loadHeroes()
    }

    private func loadHeroes() {
        loadingIndicator.startAnimating()

        heroService.fetchHeroes { [weak self] result in
            guard let self = self else { return }

            self.loadingIndicator.stopAnimating()

            switch result {
            case .success(let heroes):
                self.heroes = heroes
                self.tableView.reloadData()

            case .failure(let error):
                print("API Error: \(error.localizedDescription)")
            }
        }
    }
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return heroes.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "HeroCell",
            for: indexPath
        ) as? HeroCell else {
            return UITableViewCell()
        }

        let hero = heroes[indexPath.row]

        cell.configure(with: hero)

        return cell
    }
    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        guard segue.identifier == "showHeroDetail",
              let detailVC = segue.destination as? HeroDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return
        }

        detailVC.hero = heroes[indexPath.row]
    }
}
