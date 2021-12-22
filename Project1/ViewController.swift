//
//  ViewController.swift
//  Project1
//
//  Created by Eduard Tokarev on 12.12.2021.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        
        let sortedItems = items.sorted()
        for item in sortedItems {
            if item.hasPrefix("nssl") {
                
                pictures.append(item)
            }
        }
        
        print(pictures)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
//        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            
            vc.selectedPictureNumber = indexPath.row + 1
            vc.totalPictures = pictures.count
        }
    }
    
    @objc func shareTapped() {
        

        let vc = UIActivityViewController(activityItems: ["https://itunes.apple.com/app/id1440611372"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}

