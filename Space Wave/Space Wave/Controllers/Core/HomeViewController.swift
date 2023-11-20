import UIKit

// TODO: - Этот View Controller мы сделали стартовым!
class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browse"
        view.backgroundColor = .systemBackground
    }
    
    private func fetchData() {
        APICaller.shared.gerRecommendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement() {
                        seeds.insert(random)
                    }
                }
                
                APICaller.shared.getRecommendations(genres: seeds) { _ in
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
