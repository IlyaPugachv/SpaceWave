import UIKit

final class WelcomeViewController: UIViewController {
    
    private var nameLabelApp: UILabel = {
        let label = UILabel()
        label.text = "Space Wave"
        label.textColor = .white
        label.font = .systemFont(ofSize: 35, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign in Space Wave", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button }()
    
    private let imageView: UIImageView = {
        let imageBackground = UIImageView()
        imageBackground.contentMode = .scaleAspectFill
        imageBackground.image = UIImage(named: "imageViewBackground")
        return imageBackground
    }()
    
    private let overlayView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(signInButton)
        view.addSubview(nameLabelApp)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        overlayView.frame = view.bounds
        imageView.frame = view.bounds
        nameLabelApp.frame = CGRect(x: 10, 
                                    y: 70,
                                    width: view.width-20,
                                    height: 40)
        
        signInButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.comletionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC, animated: true)
    }
}
