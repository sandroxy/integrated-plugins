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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PluginCell")
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
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        entries[indexPath.row].action(self)
    }
}
