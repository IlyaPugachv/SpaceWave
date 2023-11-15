import UIKit
import Lottie

class LaunchScreenWithAnimationViewController: UIViewController {
    
    var closure: (() -> ())?
    private let lottieView = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bootScreenDisplay()
        displayingAppBootScreenAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.lottieView.stop()
            self?.closure?()
        }
    }
    
    private func bootScreenDisplay() {
        let label = UILabel()
        label.text = "Space Wave"
        label.textColor = .white
        label.font = .systemFont(ofSize: 32, weight: .bold)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func displayingAppBootScreenAnimation() {
        let animation = LottieAnimation.named("shootingStars")
        lottieView.animation = animation
        lottieView.contentMode = .scaleAspectFit
        lottieView.loopMode = .playOnce
        lottieView.animationSpeed = 0.7
        lottieView.play()
        
        lottieView.frame = CGRect(x: view.frame.width/2 - 100, y: 250, width: 150, height: 150)
        view.addSubview(lottieView)
    }
}






