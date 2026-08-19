import UIKit
import Levixel

final class LevixelDemoViewController: UIViewController {
    private enum DemoAsset {
        case image(source: URL, thumbnail: URL)
        case video(source: URL, poster: URL)

        var mediaItem: LevixelMediaItem {
            switch self {
            case .image(let source, let thumbnail):
                return .imageURL(source, thumbnailURL: thumbnail, placeholder: nil)
            case .video(let source, let poster):
                return .video(url: source, poster: poster)
            }
        }

        var thumbnailURL: URL {
            switch self {
            case .image(_, let thumbnail):
                return thumbnail
            case .video(_, let poster):
                return poster
            }
        }
    }

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private var galleryDatasource: LevixelDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Levixel"
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = .systemBackground

        setupLayout()

        let galleryAssets: [DemoAsset] = [
            .image(
                source: URL(string: "https://picsum.photos/id/1025/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1025/400/600")!
            ),
            .video(
                source: URL(string: "https://storage.googleapis.com/exoplayer-test-media-0/BigBuckBunny_320x180.mp4")!,
                poster: URL(string: "https://picsum.photos/id/1024/800/450")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1035/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1035/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1050/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1050/600/400")!
            ),
            .video(
                source: URL(string: "https://media.w3.org/2010/05/bunny/trailer.mp4")!,
                poster: URL(string: "https://picsum.photos/id/1044/800/450")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1015/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1015/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1018/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1018/600/400")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1003/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1003/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1011/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1011/600/400")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1027/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1027/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1002/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1002/600/400")!
            ),
            .video(
                source: URL(string: "https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4")!,
                poster: URL(string: "https://picsum.photos/id/1069/800/450")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1043/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1043/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1049/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1049/600/400")!
            ),
            .video(
                source: URL(string: "https://media.w3.org/2010/05/sintel/trailer.mp4")!,
                poster: URL(string: "https://picsum.photos/id/1070/800/450")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1060/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1060/400/600")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1074/2400/1600")!,
                thumbnail: URL(string: "https://picsum.photos/id/1074/600/400")!
            ),
            .image(
                source: URL(string: "https://picsum.photos/id/1084/1600/2400")!,
                thumbnail: URL(string: "https://picsum.photos/id/1084/400/600")!
            )
        ]

        let galleryItems = galleryAssets.map(\.mediaItem)

        let mainDatasource = LevixelArrayDataSource(items: galleryItems)
        galleryDatasource = mainDatasource
        addSection(
            title: "Mixed gallery (14 images + 4 videos)",
            assets: galleryAssets,
            datasource: mainDatasource,
            galleryIdPrefix: "native-shared"
        )
    }

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func addSection(title: String, assets: [DemoAsset], datasource: LevixelDataSource, galleryIdPrefix: String) {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.text = title
        contentStack.addArrangedSubview(titleLabel)

        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 12
        rowStack.distribution = .fillEqually
        contentStack.addArrangedSubview(rowStack)

        var currentRow = rowStack
        for (index, asset) in assets.enumerated() {
            if index > 0 && index % 2 == 0 {
                currentRow = UIStackView()
                currentRow.axis = .horizontal
                currentRow.spacing = 12
                currentRow.distribution = .fillEqually
                contentStack.addArrangedSubview(currentRow)
            }

            let thumb = makeThumbnailView(asset: asset)
            currentRow.addArrangedSubview(thumb)
            thumb.heightAnchor.constraint(equalToConstant: 120).isActive = true

            thumb.setupLevixelViewer(
                dataSource: datasource,
                initialIndex: index,
                configuration: LevixelViewerConfiguration(theme: .dark),
                galleryId: galleryIdPrefix
            )
        }
    }

    private func makeThumbnailView(asset: DemoAsset) -> UIImageView {
        let thumb = UIImageView()
        thumb.backgroundColor = .secondarySystemBackground
        thumb.contentMode = .scaleAspectFill
        thumb.clipsToBounds = true
        thumb.layer.cornerRadius = 10

        loadImage(url: asset.thumbnailURL, into: thumb)

        if case .video = asset {
            let badge = UILabel()
            badge.translatesAutoresizingMaskIntoConstraints = false
            badge.text = "VIDEO"
            badge.textColor = .white
            badge.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            badge.backgroundColor = UIColor.black.withAlphaComponent(0.62)
            badge.textAlignment = .center
            badge.layer.cornerRadius = 6
            badge.clipsToBounds = true
            thumb.addSubview(badge)
            NSLayoutConstraint.activate([
                badge.leadingAnchor.constraint(equalTo: thumb.leadingAnchor, constant: 8),
                badge.bottomAnchor.constraint(equalTo: thumb.bottomAnchor, constant: -8),
                badge.widthAnchor.constraint(equalToConstant: 50),
                badge.heightAnchor.constraint(equalToConstant: 20)
            ])
        }
        return thumb
    }

    private func loadImage(url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}
