import UIKit

final class PluginListViewController: UITableViewController {
    private struct PluginEntry {
        let title: String
        let subtitle: String?
        let systemImage: String
        let action: (UIViewController) -> Void
    }

    private let entries: [PluginEntry] = [
        PluginEntry(
            title: "Levixel",
            subtitle: "Shared-transition image and video viewer",
            systemImage: "photo.on.rectangle"
        ) { host in
            let controller = LevixelDemoViewController()
            host.navigationController?.pushViewController(controller, animated: true)
        },
    ]

    init() {
        super.init(style: .insetGrouped)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iOS Native Plugins"
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.largeTitleDisplayMode = .always

        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = 94
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.tableHeaderView = makeCatalogHeader()
        tableView.contentInset.bottom = 24
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PluginCell")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let header = tableView.tableHeaderView, header.frame.width != tableView.bounds.width else { return }
        header.frame.size.width = tableView.bounds.width
        tableView.tableHeaderView = header
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entries.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PluginCell", for: indexPath)
        let entry = entries[indexPath.row]
        var content = UIListContentConfiguration.subtitleCell()
        content.text = entry.title
        content.secondaryText = entry.subtitle
        content.image = UIImage(systemName: entry.systemImage)
        content.imageProperties.tintColor = .systemIndigo
        content.imageProperties.maximumSize = CGSize(width: 28, height: 28)
        content.imageToTextPadding = 15
        content.textProperties.font = .systemFont(ofSize: 17, weight: .semibold)
        content.secondaryTextProperties.font = .systemFont(ofSize: 13)
        content.secondaryTextProperties.color = .secondaryLabel
        content.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 14)
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        var background = UIBackgroundConfiguration.listGroupedCell()
        background.backgroundColor = .secondarySystemGroupedBackground
        cell.backgroundConfiguration = background
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        76
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let container = UIView()

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Available plugins"
        titleLabel.textColor = UIColor(red: 23 / 255, green: 32 / 255, blue: 51 / 255, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)

        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Open a plugin to verify its public artifact."
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 13)

        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 22),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
        ])
        return container
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        entries[indexPath.row].action(self)
    }

    private func makeCatalogHeader() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 104))
        header.backgroundColor = .clear

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "NATIVE PLUGIN LAB"
        label.textColor = .systemIndigo
        label.font = .systemFont(ofSize: 11, weight: .semibold)

        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = "Packaged plugin artifacts, isolated in focused verification screens."
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0

        header.addSubview(label)
        header.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: header.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
        ])
        return header
    }
}
