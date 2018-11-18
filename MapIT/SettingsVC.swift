//
//  SettingsVC.swift
//  MapIT
//
//  Created by Mikhail Lutskiy on 18/11/2018.
//  Copyright © 2018 Mikhail Lutskii. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {

    @IBOutlet weak var roundSlider: PRGRoundRangeSlider!
    @IBOutlet weak var settingsSegment: UISegmentedControl!
    @IBOutlet weak var bicycleStops: UISegmentedControl!
    @IBOutlet weak var publicTransportStops: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundSlider.messageForValue = { (startValue,endValue) in
            return "\(Int(startValue*100))%-\(Int(endValue*100))"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsSegment.selectedSegmentIndex == 0 ? 0:6
    }

    @IBAction func settingsAction(_ sender: UISegmentedControl) {
        self.tableView.reloadData()
        tableView.tableHeaderView?.isHidden = sender.selectedSegmentIndex == 0 ? false : true
    }
    
    @IBAction func bicycleAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SearchManager.shared.bicycleM = 100.0
        case 1:
            SearchManager.shared.bicycleM = 250.0
        case 2:
            SearchManager.shared.bicycleM = 500.0
        default:
            SearchManager.shared.bicycleM = 1500.0
        }
    }
    
    @IBAction func publicTransportAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            SearchManager.shared.publicTransportM = 100.0
        case 1:
            SearchManager.shared.publicTransportM = 250.0
        case 2:
            SearchManager.shared.publicTransportM = 500.0
        default:
            SearchManager.shared.publicTransportM = 1500.0
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
