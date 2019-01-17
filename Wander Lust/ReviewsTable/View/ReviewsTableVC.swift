//
//  ReviewsTableVC.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/14/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit


protocol ReviewsDisplayLogic: class {
    func displayTable(reviewsArray: [ReviewData])
}


class ReviewsTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ReviewsDisplayLogic, UISearchBarDelegate {

    var tableView: UITableView!
    var reviewsArray = [ReviewData]()
    var interactor: ReviewsBusinessLogic?
    var placeData: PlaceData!
    var searchBar: UISearchBar!
    var sortLatestBtn: UIButton!
    var sortOldestBtn: UIButton!
    var topView: UIView!
    var searchBtn: UIButton!
    var websiteBtn: UIBarButtonItem!
    var wishListBtn: UIBarButtonItem!
    
    
    var reviewsURL: String = ""
    var anagramStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViper()
        setUpLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchOrders()
    }
    
    func setUpViper(){
        let viewController = self
        let interactor = ReviewsTableInteractor()
        let presenter = ReviewsTablePresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
    }

    func setUpLayout(){
        
        self.view.backgroundColor = UIColor.white
        
        websiteBtn = UIBarButtonItem(title: "Visit Website", style: .done, target: self, action: #selector(viewWebsite(sender:)))
        
        //wishListBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addToWishList(sender:)))
        
        wishListBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "wishlist_icon"), style: UIBarButtonItemStyle.done, target: self, action: #selector(addToWishList(sender:)))
        
        self.navigationItem.rightBarButtonItems = [wishListBtn, websiteBtn]
        
        topView = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height*(1/4)))
        topView.backgroundColor = UIColor.gray
        self.view.addSubview(topView)
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 30, width: self.view.frame.width, height: self.topView.frame.height * 0.3))
        searchBar.delegate = self
        searchBar.backgroundColor = UIColor.black
        searchBar.placeholder = "Reviews for this location and category"
        self.topView.addSubview(searchBar)
        
        searchBtn = UIButton(frame: CGRect(x: self.view.frame.width * 0.3, y: searchBar.frame.height+30, width: self.view.frame.width * 0.4, height: self.topView.frame.height * 0.2))
        searchBtn.setTitle("SEARCH", for: .normal)
        searchBtn.backgroundColor = UIColor.black
        searchBtn.addTarget(self, action: #selector(searchReviews(sender:)), for: UIControlEvents.touchUpInside)
        topView.addSubview(searchBtn)
        
        let sortConstraint = searchBar.frame.height+searchBtn.frame.height+35
        
        sortLatestBtn = UIButton(frame: CGRect(x: 0, y: sortConstraint, width: self.view.frame.width/2, height: self.topView.frame.height * 0.2))
        sortLatestBtn.backgroundColor = UIColor.darkGray
        sortLatestBtn.setTitle("Sort by Latest", for: .normal)
        sortLatestBtn.addTarget(self, action: #selector(sortDescending(sender:)), for: UIControlEvents.touchUpInside)
        self.topView.addSubview(sortLatestBtn)
        
        sortOldestBtn = UIButton(frame: CGRect(x: self.view.frame.width/2, y: sortConstraint, width: self.view.frame.width/2, height: self.topView.frame.height * 0.2))
        sortOldestBtn.backgroundColor = UIColor.black
        sortOldestBtn.setTitle("Sort by Oldest", for: .normal)
        sortOldestBtn.addTarget(self, action: #selector(sortAscending(sender:)), for: UIControlEvents.touchUpInside)
        self.topView.addSubview(sortOldestBtn)
        
        tableView = UITableView(frame: CGRect(x: 0, y: self.topView.frame.height*1.4, width: self.view.frame.width, height: self.view.frame.height*(3/4)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.black
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(ReviewTableCell.self, forCellReuseIdentifier: "review_cell")
        self.view.addSubview(tableView)
    }
    
    func fetchOrders() {
        interactor?.makeRequest(url: placeData.reviews)
    }
    
    func displayTable(reviewsArray: [ReviewData]) {
        self.reviewsArray = reviewsArray
        tableView.reloadData()
    }
    
    @objc func sortAscending(sender: UIButton!){
        self.reviewsArray.sort(by: {$0.time < $1.time})
        tableView.reloadData()
    }
    
    @objc func sortDescending(sender: UIButton!){
        self.reviewsArray.sort(by: {$0.time > $1.time})
        tableView.reloadData()
    }
    
    @objc func searchReviews(sender: UIButton!){
        reviewsArray.removeAll()
        tableView.reloadData()
        reviewsURL = "http://tour-pedia.org/api/getReviews?location=\(placeData.location)&keyword=\(anagramStr)"
        interactor?.makeRequest(url: reviewsURL)
        tableView.reloadData()
        //print(reviewsURL)
    }
    
    
    //Table View Stubs
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "review_cell", for: indexPath) as? ReviewTableCell {
            if indexPath.row%2 == 0 {
                cell.backgroundColor = UIColor.black
            }
            else {
                cell.backgroundColor = UIColor.darkGray
            }
            cell.configureCell(reviewData: self.reviewsArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reviewsArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reviewDetailVC = ReviewDetailVC()
        reviewDetailVC.reviewData = reviewsArray[indexPath.row]
        self.navigationController?.pushViewController(reviewDetailVC, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anagramStr = searchText
    }
    
    @objc func viewWebsite(sender: UIButton!) {
        if let urlToServer = URL.init(string: self.placeData.details) {
            let task = URLSession.shared.dataTask(with: urlToServer, completionHandler: { (data, response, error) in
                if error != nil || data == nil {
                    print("Error")
                }
                else {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, AnyObject> {
                        if let websiteLink = jsonObject!["website"]{
                            DispatchQueue.main.async {
                                let websiteURL = URL(string: websiteLink as! String)
                                UIApplication.shared.open(websiteURL!, options: [:], completionHandler: nil)
                            }
                        }
                        
                    }
                }
            })
            task.resume()
        }
    }
    
    @objc func addToWishList(sender: UIButton!){
        let wishListVC = WishListVC()
        wishListVC.placeData = self.placeData
        self.navigationController?.pushViewController(wishListVC, animated: true)
    }
    
    

}
