//
//  ViewController.swift
//  NewsApp
//
//  Created by Mushfiq Humayoon on 26/05/22.
//

import UIKit

class ViewController: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!

// MARK: - Vars & Lets
    var news = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let refreshControl = UIRefreshControl()
// MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        setupRefreshControl()
        loadData()
    }
// MARK: - View Setup
    private func setupNavigationBar() {
        title = "NewsJet"
        navigationItem.titleView?.tintColor = UIColor.systemIndigo
    }
    private func setupTableView() {
        let articleNib = UINib(nibName: ArticleCell.viewIdentifier(), bundle: Bundle.main)
        tableView.register(articleNib, forCellReuseIdentifier: ArticleCell.viewIdentifier())
        tableView.refreshControl = refreshControl

    }
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshNews(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching new articles ...", attributes: .none)
    }
    @objc private func refreshNews(_ sender: Any) {
        loadData(again: true)
    }
// MARK: - Load Data from API
    private func loadData(again: Bool = false) {
        let serviceManager = ServiceManager.init()
        let url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=1238b0e7c30d488b8aab00e1ad9e3863"
        serviceManager.loadJson(from: url) { articles in
            self.news = articles
            if again {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
}
// MARK: - Tableview DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.viewIdentifier(), for: indexPath) as? ArticleCell else { return UITableViewCell() }
        let article = news[indexPath.row]
        cell.setContent(with: article)
        return cell
    }
}
// MARK: - Tableview Delegates
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = news[indexPath.row]
        let storyboard = UIStoryboard(name: "WebView", bundle: nil)
        if let webViewController = storyboard.instantiateInitialViewController() as? WebViewController {
            webViewController.url = URL(string: article.url)
             navigationController?.pushViewController(webViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

