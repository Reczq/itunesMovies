import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var movieData: ResultsModel?

    init(with movieData: ResultsModel) {
        self.movieData = movieData

        super.init(nibName: nil, bundle: nil)
        self.edgesForExtendedLayout = []
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }

    private func prepareView() {
        titleLabel.text = movieData?.name
    }
}
