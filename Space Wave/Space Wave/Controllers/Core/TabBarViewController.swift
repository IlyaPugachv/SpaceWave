import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = CollectionViewController()
        
        // TODO: - Потом названия вкладок навигации нужно будет убрать!
        vc1.title = "Browse"
        vc2.title = "Podcasts and books"
        vc3.title = "Collection"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        // Выставляем цвет навигации в цвет системы
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "music.note.house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Podcasts and books", image: UIImage(systemName: "mic.and.signal.meter"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Collection", image: UIImage(systemName: "heart"), tag: 1)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true

        // TODO: Устанавливаем nav1, nav2, nav3 как контроллеры вкладок для отображения пользователю
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}
