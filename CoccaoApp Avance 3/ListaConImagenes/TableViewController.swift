//
//  TableViewController.swift
//  ListaConImagenes
//
//  Created by Miguel Angel Herrera Perez on 02/03/23.
//

import UIKit

class TableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    let searchController = UISearchController()
    @IBOutlet weak var shapeTableView: UITableView!
    
    var shapeList = [Shape]()
    var filteredShapes = [Shape]()
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            initList()
            initSearchController()
        }
        
        func initList()
        {
            
            let Salon0 = Shape(Salon: "Salon AS01", UbSalon: "AS01 UA", imageName: "cuadro1", imageUb: "neko")
            shapeList.append(Salon0)
            
            let Lab0 = Shape(Salon: "Laboratorio 01", UbSalon: "Lab 01", imageName: "cuadro1", imageUb: "neko")
            shapeList.append(Lab0)
            
        }
    
        func initSearchController() {
            searchController.loadViewIfNeeded()
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.returnKeyType = UIReturnKeyType.done
            definesPresentationContext = true
        
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = true
            searchController.searchBar.scopeButtonTitles = ["Todos", "Salon","Laboratorio"]
            searchController.searchBar.delegate = self
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if(searchController.isActive) {
                return filteredShapes.count
            }
            return shapeList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as!
            TableViewCell
            
            let thisShape: Shape!
            if (searchController.isActive) {
                thisShape = filteredShapes[indexPath.row]
            } else {
                thisShape = shapeList[indexPath.row]
            }
            
            tableViewCell.shapeName.text = thisShape.Salon
            tableViewCell.shapeImage.image = UIImage(named: thisShape.imageName)
            
            return tableViewCell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "detailSegue") {
            let indexPath = self.shapeTableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? TableViewDetail
            
            let selectedShape: Shape!
            if(searchController.isActive) {
                selectedShape = filteredShapes[indexPath.row]
            }
            else {
                selectedShape = shapeList[indexPath.row]
            }
            
            tableViewDetail!.selectedShape = selectedShape
            self.shapeTableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    
    func filterForSearchTextAndScopeButton(searchText: String, scopeButton : String = "All") {
        filteredShapes = shapeList.filter {
            shape in
            let scopeMatch = (scopeButton == "All" || shape.Salon.lowercased().contains(scopeButton.lowercased()))
            if(searchController.searchBar.text != "") {
                let searchTextMatch = shape.Salon.lowercased().contains(searchText.lowercased())
                
                return scopeMatch && searchTextMatch
            } else {
                return scopeMatch
            }
        }
        shapeTableView.reloadData()
    }
    
    @IBAction func VolverInicio(segue: UIStoryboardSegue! ){
          
    }
    
}

