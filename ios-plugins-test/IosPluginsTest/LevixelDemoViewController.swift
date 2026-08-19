import UIKit
import Levixel

final class LevixelDemoViewController: UIViewController {
    private enum DemoAsset {
        case image(URL)
        case video(url: URL, poster: URL)
    }

    private let scrollView = UIScrollView()
    private let contentStack = UIStackView()
    private var galleryDatasource: LevixelDataSource?
    private var videoDatasource: LevixelDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Levixel Demo"
        view.backgroundColor = .systemBackground

        setupLayout()

        let galleryAssets: [DemoAsset] = [
            .image(URL(string: "https://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg")!),
            .image(URL(string: "https://static.jyshare.com/images/runoob-logo.png")!),
            .image(URL(string: "https://www.runoob.com/wp-content/uploads/2013/11/img_logo.gif")!),
            .image(URL(string: "https://www.runoob.com/wp-content/themes/w3cschool.cc/assets/img/logo-domain-green2.png")!),
            .image(URL(string: "https://www.w3school.com.cn/i/eg_tulip.jpg")!),
            .image(URL(string: "https://www.w3school.com.cn/i/eg_cute.gif")!),
            .image(URL(string: "https://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg?v=2")!),
            .image(URL(string: "https://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg?v=3")!),
            .video(
                url: URL(string: "https://www.runoob.com/try/demo_source/movie.mp4")!,
                poster: URL(string: "https://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg")!
            ),
            .video(
                url: URL(string: "https://www.w3school.com.cn/example/html5/mov_bbb.mp4")!,
                poster: URL(string: "https://static.jyshare.com/images/runoob-logo.png")!
            )
        ]

        let galleryItems = galleryAssets.map { asset -> LevixelMediaItem in
            switch asset {
            case .image(let url):
                return .imageURL(url, placeholder: nil)
            case .video(let url, let poster):
                return .video(url: url, poster: poster)
            }
        }

        let mainDatasource = LevixelArrayDataSource(items: galleryItems)
        galleryDatasource = mainDatasource
        addSection(
            title: "图库混合场景（8图+2视频）",
            assets: galleryAssets,
            datasource: mainDatasource,
            galleryIdPrefix: "ios-mix"
        )

        let videoAssets: [DemoAsset] = [
            .video(
                url: URL(string: "https://www.runoob.com/try/demo_source/movie.mp4")!,
                poster: URL(string: "https://www.runoob.com/wp-content/uploads/2016/04/trolltunga.jpg")!
            ),
            .video(
                url: URL(string: "https://www.w3school.com.cn/example/html5/mov_bbb.mp4")!,
                poster: URL(string: "https://static.jyshare.com/images/runoob-logo.png")!
            )
        ]
        let videoItems = videoAssets.map { asset -> LevixelMediaItem in
            switch asset {
            case .video(let url, let poster):
                return .video(url: url, poster: poster)
            case .image(let url):
                return .imageURL(url, placeholder: nil)
            }
        }
        let onlyVideoDatasource = LevixelArrayDataSource(items: videoItems)
        videoDatasource = onlyVideoDatasource
        addSection(
            title: "视频场景（2视频）",
            assets: videoAssets,
            datasource: onlyVideoDatasource,
            galleryIdPrefix: "ios-video"
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
            if index > 0 && index % 3 == 0 {
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

        switch asset {
        case .image(let url):
            loadImage(url: url, into: thumb)
        case .video(_, let poster):
            loadImage(url: poster, into: thumb)
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
