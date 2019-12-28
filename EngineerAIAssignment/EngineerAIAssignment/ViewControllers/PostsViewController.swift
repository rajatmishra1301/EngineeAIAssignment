//
//  ViewController.swift
//  EngineerAIAssignment
//
//  Created by Grave Walker on 12/28/19.
//  Copyright © 2019 Rajat Mishra. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var postsTableView: UITableView!
    @IBOutlet weak var dataLoadIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loadMoreIndicatorView: UIActivityIndicatorView!
    
    //MARK: - Properties
    private var page: Int = 1
    private var posts: [Post] = [] {
        didSet {
            navigationItem.title = self.posts.count == 0 ? "No posts available" : "\(self.posts.count) Posts"
        }
    }
    
    //MARK: - Controls
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        return control
    }()
    
    //MARK: - Main View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        postsTableView.refreshControl = refreshControl
        fetchPosts()
    }
    
    //MARK: - Other Methods
    @objc func pullToRefresh(sender: UIRefreshControl) {
        page = 1
        fetchPosts(isPullToRefresh: true)
    }
    
    private func selectDeselectPost(onPath indexPath: IndexPath) {
        let oldValue = self.posts[indexPath.row].isSelected
        self.posts[indexPath.row].isSelected = !oldValue
        if let cell = postsTableView.cellForRow(at: indexPath) as? PostTableViewCell {
            cell.post = self.posts[indexPath.row]
        }
    }
    
    //MARK: - API Calls
    func fetchPosts(isPullToRefresh: Bool = false, isLoadMore: Bool = false) {
        if isLoadMore || isPullToRefresh {
            dataLoadIndicatorView.stopAnimating()
            if !isPullToRefresh {
                loadMoreIndicatorView.startAnimating()
            }
        } else {
            dataLoadIndicatorView.startAnimating()
            loadMoreIndicatorView.stopAnimating()
        }
        APIClient.getPosts(forPage: page) { (result) in
            self.dataLoadIndicatorView.stopAnimating()
            self.errorMessageLabel.text = ""
            switch result {
            case .success(let responseData):
                let newPosts = responseData.posts ?? []
                if isPullToRefresh {
                    self.posts = newPosts
                } else {
                    var oldPosts = self.posts
                    oldPosts.append(contentsOf: newPosts)
                    self.posts = oldPosts
                }
                break
            case .failure(let error):
                let errorMessage = APIClient.handleFailure(for: error)
                if self.posts.count == 0 {
                    self.errorMessageLabel.text = errorMessage
                } else {
                    Constants.showAlert(withMessage: errorMessage, on: self)
                }
                break
            }
            if self.posts.count == 0 {
                self.postsTableView.reloadData()
            } else {
                self.postsTableView.beginUpdates()
                var currentRows = self.postsTableView.numberOfRows(inSection: 0)
                if isPullToRefresh {
                    var indexPathsToDelete = [IndexPath]()
                    for i in 0..<self.postsTableView.numberOfRows(inSection: 0) {
                        indexPathsToDelete.append(IndexPath(row: i, section: 0))
                    }
                    self.postsTableView.deleteRows(at: indexPathsToDelete, with: .none)
                    currentRows = 0
                }
                var indexPathsToInsert = [IndexPath]()
                for i in currentRows..<self.posts.count {
                    indexPathsToInsert.append(IndexPath(row: i, section: 0))
                }
                if indexPathsToInsert.count > 0 {
                    self.postsTableView.insertRows(at: indexPathsToInsert, with: isPullToRefresh ? .none : .middle)
                }
                self.postsTableView.endUpdates()
            }
            self.loadMoreIndicatorView.stopAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}

extension PostsViewController: PostTableViewCellDelegate {
    
    func didTapOnSwitch(newValue: Bool, forPostIndex: Int?) {
        if let selectedPostIndex = forPostIndex {
            let oldValue = self.posts[selectedPostIndex].isSelected
            self.posts[selectedPostIndex].isSelected = !oldValue
        }
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableCell = tableView.dequeueReusableCell(withIdentifier: TableCellIdentifiers.PostsTableCell, for: indexPath) as! PostTableViewCell
        postTableCell.index = indexPath.row
        postTableCell.post = posts[indexPath.row]
        postTableCell.postCellDelegate = self
        return postTableCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectDeselectPost(onPath: indexPath)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectDeselectPost(onPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == (posts.count - 3)) && !loadMoreIndicatorView.isAnimating {
            page += 1
            fetchPosts(isPullToRefresh: false, isLoadMore: true)
        }
    }
    
}
