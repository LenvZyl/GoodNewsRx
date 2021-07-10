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
    private var articles: [Article] = []
    @IBOutlet weak var tableView: UITableView!
    var ten = 10
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
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + Commons.apiKey)!
        Observable.just(url).flatMap{ url -> Observable<Data> in
            let request = URLRequest(url: url)
            return URLSession.shared.rx.data(request: request)
        }.map { data -> [Article]? in
            let articles = try? JSONDecoder().decode(ArticleList.self, from: data).articles
            return articles
        }.subscribe(onNext: { articles in
            if let articles = articles{
                self.articles = articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }).disposed(by: disposeBag)
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell else {
            fatalError("Table View Cell not found")
        }
        cell.titleLabel.text = articles[indexPath.row].title
        cell.descriptionLabel.text = articles[indexPath.row].description
        cell.descriptionLabel.textColor = .gray.withAlphaComponent(0.5)
        return cell
    }
    
    
}

