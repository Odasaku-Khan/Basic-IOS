import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var folowingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var posts: UILabel!
    @IBAction func next(_ sender: Any) {
        let random = Int.random(in: 0..<accountList.count)
        showAccount(index: random)
    }
    @IBAction func messageNotworking(_ sender: Any) {
        let alert = UIAlertController(title: "Not working", message: "This feature is not working", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showAccount(index: Int) {
        let account = accountList[index]
        nameLabel.text = account.name
        followersLabel.text = account.subscribers
        folowingLabel.text = account.following
        posts.text = account.posts
        about.text = account.about
        bioLabel.text = account.aboutDescription
        imageView.image = UIImage(named: account.image)
    }
    override func viewDidLoad() {
        let random = Int.random(in: 0..<accountList.count)
        showAccount(index: random)
        super.viewDidLoad()
    }


}

