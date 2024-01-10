import UIKit

class PodcastsAndBooksViewController: UIViewController {
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "This section will be added in the next updates"
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
                  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(newsLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsLabel.frame = CGRect(x: 10,
                                    y: 350,
                                    width: view.width-20,
                                    height: 40)
    }
}
