//
//  ViewController.swift
//  SrinuNYTimes
//
//  Created by Srinu K on 23/09/23.
//


import UIKit

let sampleKey = "92da9e2a0d954db4a8b1c4e9df303177"
public let nyUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + sampleKey

class ViewController: UIViewController{
    @IBOutlet var listArticlesTableView: UITableView!
    var headlines: NYTopHeadlines?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listArticlesTableView.isHidden = true
        self.title = "NY Times"
        // Do any additional setup after loading the view, typically from a nib.
        if Reachability.connectedToNetwork(){
            DispatchQueue.main.async {
                Helper().showActivityIndicator(uiView: self.view)
            }
           // self.getDataFromUrl(urlStr: nyUrl)
            HeadlinesViewModel().getDataFromUrl(urlStr: nyUrl, completionHandler: {
                status, nyModel in
                DispatchQueue.main.async {
                    Helper().hideActivityIndicator(uiView: self.view)
                }
                if status {
                    DispatchQueue.main.async {
                        self.headlines = nyModel
                        self.listArticlesTableView.isHidden = false
                        self.listArticlesTableView.delegate = self
                        self.listArticlesTableView.dataSource = self
                        self.listArticlesTableView.reloadData()
                    }
                 
                }else {
                    self.popupAlert(title: "Alert", message: "Not recived the data", actionTitles: ["Ok"], actions:[{action1 in
               
                                   }, nil])
                }
            })
            
        }else{
            self.popupAlert(title: "NO Network", message: "Please check your Internet connection", actionTitles: ["Ok"], actions:[{action1 in }, nil])
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
// MARK: - Table view methods
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.headlines?.articles.count  ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        guard  let resultObj =  self.headlines?.articles[indexPath.row] else {
        return cell
        }
        cell.updateList(article: resultObj)
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let resultObj =  self.headlines?.articles[indexPath.row] else {
            return
        }
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let detailViewController = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.nyURL = resultObj.url ?? ""
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

extension UIViewController {
    
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    }
  
}
/**
 Get Image from URl
 **Discussion**
 Creating extension to UIImageView
 Get the resluts from service and showing on cell image with URLSession
 */

extension UIImageView {
    public func imageFromURL(urlString: String) {
//        self.layer.cornerRadius = self.frame.size.width / 2
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        activityIndicator.startAnimating()
        
        if self.image == nil{
            self.addSubview(activityIndicator)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                activityIndicator.removeFromSuperview()
                self.image = image
            })
            
        }).resume()
    }
}
