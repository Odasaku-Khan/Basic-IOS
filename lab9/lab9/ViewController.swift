//
//  ViewController.swift
//  lab9
//
//  Created by Ablaikhan Nussipakhyn on 11/4/26.
//

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }


}

