//
//  DetailsViewController.swift
//  DataFetchOptimised
//
//  Created by Aalok Parikh on 04/05/24.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var objDetails = PostObjectElement(userID: 1, id: 1, title: "Title", body: "Body String")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "\(objDetails.userID)"
        lblID.text = "\(objDetails.id)"
        lblTitle.text = objDetails.title
        lblDescription.text = objDetails.body
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
