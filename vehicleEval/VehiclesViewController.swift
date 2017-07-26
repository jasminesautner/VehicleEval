//
//  VehiclesViewController.swift
//  vehicleEval
//
//  Created by LouieDavis on 7/19/17.
//  Copyright © 2017 jpsautner. All rights reserved.
//

import UIKit
import SwiftyJSON

class VehiclesViewController: UIViewController {
    
    @IBOutlet weak var vehicleTableView: UITableView!

    //var allVehicles = [Vehicle]()
    //var filteredVehicles = [Vehicle]()
    var orderedVehicleMakes = [String]()
    var filteredVehicleMakes = [String]()
    
    //var vehicleModelsArray = [VehicleModels]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //vehicleModelsArray.append(VehicleModels)
        
        
        guard let jsonURL = Bundle.main.url(forResource: "vehicleInformation", withExtension: "json") else {
            print("Could not find vehicleInformation.json!")
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let jsonData = try! Data(contentsOf: jsonURL)
            let vehicleData = JSON(data: jsonData)
            let allVehiclesData = vehicleData["results"].arrayValue
            
            //self?.allVehicles = allVehiclesData.map { Vehicle(json: $0) }
            let vehicles = allVehiclesData.map { Vehicle(json: $0) }
            self?.orderedVehicleMakes = Set(vehicles.map { $0.make }).sorted()
            
            DispatchQueue.main.async {
                self?.vehicleTableView.reloadData()
            }
        }
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        vehicleTableView.tableHeaderView = searchController.searchBar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        vehicleTableView = indexPath.row
//        performSegue(withIdentifier: "models", sender: "self")
//    
//    }
    
    func filterContentForSearchText(searchText: String) {
        filteredVehicleMakes = orderedVehicleMakes.filter { vehicle in
            let trimmedString = searchText.trimmingCharacters(in: CharacterSet.whitespaces).lowercased()
            if trimmedString.characters.count > 0 {
                return vehicle.lowercased().hasPrefix(trimmedString)
            }
            return false
        }
        vehicleTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //var indexPath: IndexPath = self.tableView.indexPathForSelectedRow()!
        
        
        if segue.identifier == "segueToModels" {
            if let indexPath = vehicleTableView.indexPathForSelectedRow {
                let destViewController = segue.destination as! ModelsViewController
                //let make = filteredVehicleMakes[indexPath.row]
                let make = searchController.isActive ? filteredVehicleMakes[indexPath.row] : orderedVehicleMakes[indexPath.row]
                destViewController.make = make
                
            } else {
                print("No indexpath returned")
            }
        }
        
    }
    
}



// MARK: - UITableViewDataSource

extension VehiclesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if searchController.isActive {
            return filteredVehicles.count
        } else {
           return allVehicles.count
        }
        */
        return searchController.isActive ? filteredVehicleMakes.count : orderedVehicleMakes.count
        //return orderedVehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicleCellIdentifier", for: indexPath)
        /*
        var vehicle: Vehicle
        if searchController.isActive {
            vehicle = filteredVehicles[indexPath.row]
        } else {
            vehicle = allVehicles[indexPath.row]
        }
        cell.textLabel?.text = "\(vehicle.make)"
        */
        
        // If search controller is active, set vehicle make to the filtered vehicle; else, set vehicle make to the ordered vehicle.
        let vehicleMake = searchController.isActive ? filteredVehicleMakes[indexPath.row] : orderedVehicleMakes[indexPath.row]
        cell.textLabel?.text = vehicleMake
        
        //let vehicle = orderedVehicles[indexPath.row]   //[indexPath.row]
        //cell.textLabel?.text = vehicle
        
        return cell
    }
}

extension VehiclesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


// MARK: - UISearchBarDelegate

extension VehiclesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - updateSearchResults Protocol

extension VehiclesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterContentForSearchText(searchText: text)
        }
      
    }
}



