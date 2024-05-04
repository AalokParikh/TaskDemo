//
//  ViewController.swift
//  DataFetchOptimised
//
//  Created by Aalok Parikh on 03/05/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var actView: UIActivityIndicatorView!
    @IBOutlet weak var tblView: UITableView!
    
    var arrPostData: PostObject = PostObject()
    var page: Int = 1
    let limit: Int = 10
    var lastPage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchDataFromAPI(page: page, limit: limit)
    }
    
    func fetchDataFromAPI(page: Int, limit: Int) {
        actView.startAnimating()
        let url = "https://jsonplaceholder.typicode.com/posts"
        let parameters: Parameters = [
            "_page": page,
            "_limit": limit
        ]
        NetworkManager.shared.makeAPICall(urlString: url, parameters: parameters) { jsonData in
            print(jsonData as Any)
            if let isDataAvailable =  jsonData?.isEmpty {
                self.lastPage = isDataAvailable
            }
            if let arrJsonObjs = jsonData {
                self.arrPostData.append(contentsOf: arrJsonObjs)
                self.tblView.reloadData()
                self.actView.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case "ShowDetailsIdentifier":
                print(sender as Any)
                (segue.destination as? DetailsViewController)?.objDetails = arrPostData[(sender as? IndexPath)?.row ?? 0]
                break
            default:
                break
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPostData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell") as? ListViewCell {
            
            cell.lblID.text = "\(arrPostData[indexPath.row].id)"
            cell.lblTitle.text = arrPostData[indexPath.row].title
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= arrPostData.count - 3, !lastPage {
            page += 1
            fetchDataFromAPI(page: page, limit: limit)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetailsIdentifier", sender: indexPath)
    }
}

class ListViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblID: UILabel!

}
