//
//  ViewController.swift
//  CastleRock
//
//  Created by Venkata Pranathi Immaneni on 1/22/22.
//

import UIKit

/*
 ***************************************************
 *****************  View Controller  ***************
 ***************************************************
*/
class ViewController: UIViewController {
    
    /*
     ***********  IBOutlets  ***********
    */
    @IBOutlet weak var signsTableView: UITableView!
    
    /*
     ***********  Private Properties  ***********
    */
    private let refreshControl = UIRefreshControl()
    private var signViewModel = SignsViewModel.sharedInstance
    
    
    /*
     ***********  Overrides  ***********
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signViewModel = SignsViewModel.sharedInstance
        
        self.navigationItem.title = "Signs"
        self.initialTableViewSetup()
        self.callToViewModelForUIUpdates()
    }
    
    /*
     ***********  Private Methods  ***********
    */
    
    /*
     This function is used for the initial table view setup, with pull to refresh functionality added to the table view
     */
    private func initialTableViewSetup() {
        self.signsTableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshSignsData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Signs Data ....")
        
    }
    
    /*
     This function gets called when the user pulls down the table view to refresh the data
     */
    @objc private func refreshSignsData(_ sender: Any) {
        self.callToViewModelForUIUpdates()
    }
    
    /*
     This function is used to fetch the api data from the Network Manager
     */
    private func callToViewModelForUIUpdates() {
        self.signViewModel.fetchSignsDataFromNetwork { error in
            if error != nil {
                self.showAlertOnFailures(alertMessage: "Error fetching data from the network. Please try again later: \(error!)")
            } else {
                DispatchQueue.main.async {
                    self.signsTableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        }
        
    }
    
    /*
     This function is used to display the alert message.
     -Paramater alertMessage: This is of type String. This is the message that is to be displayed on the alertViewController
     */
    private func showAlertOnFailures(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}


/*
 ***************************************************
 *****************  Extensions  *********************
 ***************************************************
*/
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    /*
     ***********  Table View Data Source  ***********
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signViewModel.signs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignNamesTableViewCell") as! SignNamesTableViewCell
        configureCell(cell, rowAtindexPath: indexPath.row)
        return cell
    }
    
    /*
     ***********  Table View Delegates  ***********
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let displayLinesViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DisplayLinesViewController") as? DisplayLinesViewController {
            let status = signViewModel.getSignStatusAtIndex(index: indexPath.row)
            displayLinesViewController.display = signViewModel.getSignDisplayAtIndex(index: indexPath.row)
            if(status == "DISPLAYING_MESSAGE") {
                displayLinesViewController.isDisplayingStatus = true
            }
            self.navigationController?.pushViewController(displayLinesViewController, animated: true)
        } else {
            self.showAlertOnFailures(alertMessage: "Display view controller doesn't exists. Please check the storyboard identifier")
        }
    }
    
    /*
     This is the helper function to configure the tableViewCell with the required data
     */
    private func configureCell(_ cell: SignNamesTableViewCell, rowAtindexPath: Int)  {
        cell.signDisplayName.text = signViewModel.getSignDisplayNameAtIndex(index: rowAtindexPath)
        let status = signViewModel.getSignStatusAtIndex(index: rowAtindexPath)
        if status == "DISPLAYING_MESSAGE" {
            cell.signDisplayName.textColor = UIColor.black
        } else {
            cell.signDisplayName.textColor = UIColor.gray
        }
    }
}
