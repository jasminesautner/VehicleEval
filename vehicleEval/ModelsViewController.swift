//
//  ModelsViewController.swift
//  vehicleEval
//
//  Created by LouieDavis on 7/24/17.
//  Copyright © 2017 jpsautner. All rights reserved.
//

import UIKit
import SwiftyJSON

class ModelsViewController: UIViewController {
    
    //var vehicleModelsArray = [String]()
    var vehicleModels = [Vehicle]()
    var make: String?

    
    
    @IBOutlet weak var modelsTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if let make = make {
            print(make)
            guard let jsonURL = Bundle.main.url(forResource: "vehicleInformation", withExtension: "json") else {
                print("Could not find vehicleInformation.json!")
                return
            }
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let jsonData = try! Data(contentsOf: jsonURL)
                let vehicleData = JSON(data: jsonData)
                let allVehiclesData = vehicleData["results"].arrayValue
                
                 let vehicles = allVehiclesData.map { Vehicle(json: $0) }
                
                self?.vehicleModels = vehicles.filter { $0.make == make }.sorted { $0.year > $1.year}
            
                DispatchQueue.main.async {
                    self?.modelsTableView.reloadData()
                }
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ModelsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return vehicleModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "modelsCell", for: indexPath) as! CustomModelTableViewCell
        
        let vehicle = vehicleModels[indexPath.row]
        
        cell.vehicleModelMake?.text = "\(String(describing: vehicle.make)), \(String(describing: vehicle.model)) "
        cell.vehicleYear?.text = "\(String(describing: vehicle.year))"
        cell.vehicleFeScore?.text = "\(vehicle.feScore)"
        
        return cell
    }
    
}
