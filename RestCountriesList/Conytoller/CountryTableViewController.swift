
import UIKit

class CountryTableViewController: UITableViewController {
    
    private var countries: [CountryElement] = []
    private let cellID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        NetworkManager.fetchData { countries in
            self.countries = countries
            dump(self.countries)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupView(){
        view.backgroundColor = .secondarySystemBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        setupNavigationBar()
        let longPressRecogniser = UILongPressGestureRecognizer(target: self, action: #selector(longPress(sender:)))
        self.view.addGestureRecognizer(longPressRecogniser)
        
        
    }
    
    @objc private func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizer.State.began {
            let touchPoint = sender.location(in: self.tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                basicActionSheet(title: countries[indexPath.row].name?.common, message: countries[indexPath.row].name?.official)
            }
        }
    }
    
    @objc private func infoButtonPressed(_ sender: UIBarButtonItem!) {
        basicAlert(title: "Country List", message: "Table List view with country information.")
    }
    
    private func setupNavigationBar(){
        title = "Country List"
        let titleImage = UIImage(systemName: "mappin.and.ellipse")
        let imageView = UIImageView(image: titleImage)
        self.navigationItem.titleView = imageView
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.label]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        
        //infoItemTapped
    }
    
    private func setupBarButton(){
        let logoutBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person") , style: .done, target: self, action: #selector(User))
           self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }
    
    @objc func User(){
        let alert = UIAlertController(title: "User Profile",
                                      message: "Username: Sivakarthi",
                                      preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Close",
                                      style: .cancel,
                                      handler: { _ in print("Cancel tap") }))

        present(alert, animated: true, completion: nil)

    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: cellID)
        // Configure the cell...
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name?.common
        cell.detailTextLabel?.text = country.name?.official
        cell.selectionStyle = .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailedCountryVC = CountryDetailedViewController()
            self.navigationController?.pushViewController(detailedCountryVC, animated: true)
            detailedCountryVC.country = countries[indexPath.row]

        }
    }

    private func basicAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let basicAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default)
            
            basicAlert.addAction(okAction)
            self.present(basicAlert, animated: true)
        }
    }
    
}



extension CountryTableViewController{
    
    private func basicActionSheet(title: String?, message: String?){
        DispatchQueue.main.async {
            let actionSheet: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(cancelAction)
            self.present(actionSheet, animated: true)
        }
    }
    
}
