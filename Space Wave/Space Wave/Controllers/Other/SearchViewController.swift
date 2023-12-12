import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
   
        let searchController: UISearchController = {
            let results = UIViewController()
            results.view.backgroundColor = .red
            let vc = UISearchController(searchResultsController: results)
            vc.searchBar.placeholder = "Любимые треки, подкасты, книги"
            vc.searchBar.searchBarStyle = .minimal
            vc.definesPresentationContext = true
            return vc
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
    }
}
