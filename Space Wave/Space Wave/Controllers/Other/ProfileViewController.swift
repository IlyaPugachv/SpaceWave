import UIKit
import SDWebImage

final class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [Section]()
    private var models = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        fetchProfile()
        title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        createTableHeader(with: model.images.first?.url, name: model.display_name, email: model.email)
        tableView.reloadData()
    }
    
    private func createTableHeader(with string: String?, name: String?, email: String?) {
        guard let urlString = string, let url = URL(string: urlString) else { return }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/2))
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        
        let emailLabel = UILabel(frame: CGRect(x: 0, y: imageView.bottom + 10, width: headerView.width, height: 20))
        emailLabel.textAlignment = .center
        emailLabel.text = name
        emailLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        headerView.addSubview(emailLabel)
        
        let nameLabel = UILabel(frame: CGRect(x: 0, y: emailLabel.bottom + 10, width: headerView.width, height: 20))
        nameLabel.textAlignment = .center
        nameLabel.text = email
        headerView.addSubview(nameLabel)
        
        tableView.tableHeaderView = headerView
    }
    
    private func failedToGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile."
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    private func configureModels() {
        sections.append(Section(title: "Your Settings", options: [Option(title: "Settings", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewSettings()
            }
        })]))
        
        sections.append(Section(title: "Account", options: [Option(title: "Sign Out", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.signOutTapped()
            }
        })]))
    }
    
    private func signOutTapped() {}

    private func viewSettings() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { sections.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { sections[section].options.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
}
