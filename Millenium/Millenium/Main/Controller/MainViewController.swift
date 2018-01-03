import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var movies: [ResultsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: "MovieCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MovieCellIdentifier")

        startNetworkService()
    }

    private func startNetworkService() {
        let networkService = NetworkingService()
        networkService.fetchData(onCompletion: { [weak self] data in
            self?.movies = data
            self?.tableView.reloadData()
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsTableViewSegue" {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.movieData = sender as? ResultsModel
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellIdentifier", for: indexPath) as! MovieCell

        cell.titleLabel.text = movies[indexPath.row].name

        if let imageURL = URL(string: movies[indexPath.row].artworkUrl100!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        //                        cell.avatarImageView.image = image
                    }
                }
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieData = movies[indexPath.row]
        performSegue(withIdentifier: "DetailsTableViewSegue", sender: movieData)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
