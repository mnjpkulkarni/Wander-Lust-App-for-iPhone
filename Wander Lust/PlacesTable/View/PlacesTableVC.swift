//
//  ViewController.swift
//  The SMBX Challenge
//
//  Created by Manoj Kulkarni on 4/13/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Firebase


protocol PlacesDisplayLogic: class {
    func displayTable(placeArray: [PlaceData])
}

class PlacesTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource, PlacesDisplayLogic, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    var placeArray = [PlaceData]()
    var baseURL: String = ""
    private var selectedLocation: String = ""
    private var selectedCategory: String = ""
    
    var tableView: UITableView!
    var locationPicker: UIPickerView!
    var categoryPicker: UIPickerView!
    var topView: UIView!
    var searchBar: UISearchBar!
    var searchBtn: UIButton!
    
    var backgroundImg: UIImageView!
    
    var interactor: PlacesBusinessLogic?
    
    private var categoriesArray = ["Select Category","accommodation","restaurant","attraction","points of interest"]
    private var locationsArray = ["Select Location","Amsterdam","Barcelona","Berlin","Dubai","London","Paris","Rome","Tuscany"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "Wander Lust"
        setUpLayout()
        setUpViper()
    }
    
    //Setup VIPER
    func setUpViper(){
        let viewController = self
        let interactor = PlacesTableInteractor()
        let presenter = PlacesTablePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    //Layouts
    func setUpLayout(){
        
        self.view.backgroundColor = UIColor.brown
        
        backgroundImg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundImg.contentMode = .scaleAspectFit
        backgroundImg.image = UIImage(named: "hotel_bg")
        self.view.addSubview(backgroundImg)
        
        topView = UIView(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: self.view.frame.height*(1/4)))
        topView.backgroundColor = UIColor.brown
        self.view.addSubview(topView)
        
        locationPicker = UIPickerView(frame: CGRect(x: 0, y: 5, width: self.view.frame.width/2, height: self.topView.frame.height * 0.7))
        locationPicker.delegate = self
        locationPicker.dataSource = self
        locationPicker.tag = 1
        self.topView.addSubview(locationPicker)
        
        categoryPicker = UIPickerView(frame: CGRect(x: self.view.frame.width/2, y: 5, width: self.view.frame.width/2, height: self.topView.frame.height * 0.7))
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.tag = 2
        self.topView.addSubview(categoryPicker)
        
        searchBtn = UIButton(frame: CGRect(x: self.view.frame.width * 0.3, y: categoryPicker.frame.height+5, width: self.view.frame.width * 0.4, height: self.topView.frame.height * 0.25))
        searchBtn.setTitle("SEARCH", for: .normal)
        searchBtn.backgroundColor = UIColor.black
        searchBtn.addTarget(self, action: #selector(searchForPlaces(sender:)), for: UIControlEvents.touchUpInside)
        self.topView.addSubview(searchBtn)
        
        tableView = UITableView(frame: CGRect(x: 0, y: self.topView.frame.height*1.4, width: self.view.frame.width, height: self.view.frame.height*(3/4)))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.alpha = 0.8
        tableView.backgroundColor = nil
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(PlacesCell.self, forCellReuseIdentifier: "places_cell")
        self.view.addSubview(tableView)
        
    }
    
    //View Stub
    func displayTable(placeArray: [PlaceData]) {
        self.placeArray = placeArray
        tableView.reloadData()
    }
    
    //Search Button Handler
    @objc func searchForPlaces(sender: UIButton!){
        placeArray.removeAll()
        tableView.reloadData()
        baseURL  = "http://tour-pedia.org/api/getPlaces?category=\(self.selectedCategory)&location=\(self.selectedLocation)&language=en"
        interactor?.makeRequest(url: baseURL)
        //print(baseURL)
    }
    
    
    //Location Picker View Stubs
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return self.locationsArray.count
        }
        else if pickerView.tag == 2 {
            return self.categoriesArray.count
        }
        return 1
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            self.view.endEditing(true)
            return locationsArray[row]
        }
        
        else if pickerView.tag == 2 {
            self.view.endEditing(true)
            return categoriesArray[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if pickerView.tag == 1 {
            let label = (view as? UILabel) ?? UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont(name: "SanFranciscoText-Light", size: 5)
            label.text = locationsArray[row]
            
            return label
        }
        
        else if pickerView.tag == 2 {
            let label = (view as? UILabel) ?? UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.font = UIFont(name: "SanFranciscoText-Light", size: 5)
            label.text = categoriesArray[row]
            
            return label
        }
        
        return UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            self.selectedLocation = locationsArray[row]
        }
        else if pickerView.tag == 2 {
            self.selectedCategory = categoriesArray[row]
            if selectedCategory == "points of interest" {
                self.selectedCategory = "poi"
            }
        }
    }


    
    
    //Table View stubs
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "places_cell", for: indexPath) as? PlacesCell {
            if indexPath.row%2 == 0 {
                cell.backgroundColor = UIColor.black
            }
            else {
                cell.backgroundColor = UIColor.darkGray
            }
            cell.configureCell(placeData: self.placeArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reviewsTableVC = ReviewsTableVC()
        reviewsTableVC.placeData = self.placeArray[indexPath.row]
        self.navigationController?.pushViewController(reviewsTableVC, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    

}

