import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FavoriteCell",
            for: indexPath
        ) as! FavouriteCell

        let item = FavoriteLibrary.items[indexPath.row]
        cell.configure(with: item)

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteLibrary.items.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showDetail",
              let detailVC = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        let selectedGame = FavoriteLibrary.items[indexPath.row]
        detailVC.item = selectedGame
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }


}

