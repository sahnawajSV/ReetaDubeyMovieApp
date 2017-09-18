//
//  ViewController.swift
//  ReetaMovieApp
//
//  Created by APPLE on 15/09/17.
//  Copyright © 2017 APPLE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var movieArray = [Movie]()
  
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadData()
    }
    
    func loadData() {

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        WebServiceManager.shared.getData(urlString: Constants.shared.MOVIE_LIST) {
            (jsonData,error) in
            
            if let jsonData = jsonData {
                
                let model = MovieModel.init(dictionary: jsonData)
              
                if let array = model?.resultsArray {
                    self.movieArray = array
                  DispatchQueue.main.async {
                    self.tableView.reloadData()
                  }
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UITableViewDataSource - 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCellID") as? MovieListCell {
            
            if indexPath.row < self.movieArray.count {
                
                let model = self.movieArray[indexPath.row]
                cell.displayMovieCell(movie: model)
                cell.movieThumbnailImageView.image = model.posterImage

                
                DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                    
                    if nil == model.posterImage {
                        self.downloadImage(indexPath: indexPath)
                    }
                }
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    //MARK: - UITableViewDelegate -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: Constants.shared.DETAIL_CONTROLLER_ID) as? MovieDetailViewController, indexPath.row < self.movieArray.count {
            viewController.movie = self.movieArray[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120 //UITableViewAutomaticDimension
    }
    
    //MARK: - ImageDownload -
    
    func downloadImage(indexPath: IndexPath) {
        
        if indexPath.row < self.movieArray.count {
            if let urlString = self.movieArray[indexPath.row].posterURL {
             
                let finalString = Constants.shared.IMAGE_DOWNLOAD_PATH + Constants.shared.IMAGE_FILE_SIZE + "\(urlString)"
                    
                WebServiceManager.shared.downloadImage(urlString: finalString) {
                    (data,error) in
                    
                    if let data = data {
                        
                        let image = UIImage.init(data: data)
                        self.movieArray[indexPath.row].posterImage = image
                        
                        if let value = self.tableView.indexPathsForVisibleRows?.contains(indexPath), value {
                            
                            if let cell = self.tableView.cellForRow(at: indexPath) as? MovieListCell {
                                
                                DispatchQueue.main.async {
                                    cell.movieThumbnailImageView.image = image
                                    cell.movieThumbnailImageView.setNeedsLayout()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

