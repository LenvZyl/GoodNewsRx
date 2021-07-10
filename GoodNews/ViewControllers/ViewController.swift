//
//  ViewController.swift
//  GoodNews
//
//  Created by Len van Zyl on 2021/07/10.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var articleList: [Article] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "GoodNews"
        tableView.delegate = self
        tableView.dataSource = self
        self.getNews()
    }
    
    private func getNews(){
        URLRequest.load(resource: ArticleList.all).subscribe(onNext: { [weak self] result in
            if let result = result  {
                self?.articleList = result.articles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Table View Cell not found")
        }
        cell.titleLabel.text = articleList[indexPath.row].title
        cell.descriptionLabel.text = articleList[indexPath.row].description
        cell.descriptionLabel.textColor = .gray.withAlphaComponent(0.5)
        return cell
    }
    
    
}

