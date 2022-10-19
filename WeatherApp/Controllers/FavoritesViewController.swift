//
//  FavoritesViewController.swift
//  WeatherApp
//
//  Created by Tony Mut on 10/17/22.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        addViews()
        
        addConstraints()
        

        // Do any additional setup after loading the view.
    }

    let favList: UITableView = {
        
        let tv = UITableView()
        
        return tv
    }()
    
    func addViews(){
        view.addSubview(favList)
    }
    
    func addConstraints(){
        
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
