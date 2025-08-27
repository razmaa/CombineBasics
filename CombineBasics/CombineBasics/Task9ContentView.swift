

import UIKit
import Combine

struct Post: Decodable {
    let title: String
}

class ViewController: UIViewController, UITableViewDataSource {
    private var tableView = UITableView()
    private var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Posts"
        
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
        
        fetchPosts()
    }
    
    private func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error:", error)
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}
