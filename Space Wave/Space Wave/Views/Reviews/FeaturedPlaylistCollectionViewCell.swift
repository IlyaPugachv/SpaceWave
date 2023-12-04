import UIKit

// MARK: - Настройка отображения плейлистов

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    // Интерфейс плейлистов
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    // MARK: - Override View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height-45,
            width: contentView.width-6,
            height: 30
        )
        let imageSize = contentView.height-45
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width-imageSize)/3,
            y: 3,
            width: imageSize,
            height: imageSize
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
