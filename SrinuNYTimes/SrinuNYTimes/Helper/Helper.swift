//
//  Helper.swift
//  NY Times
//
//  Created by Srinu K on 23/09/23.
//

import Foundation
import UIKit

class Helper {
    
    var container: UIView?
    var loadingView: UIView?
   
      var activityIndicatorTag: Int { return 999999 }
    /*
     Show customized activity indicator,
     actually add activity indicator to passing view
     
     @param uiView - add activity indicator to this view
     */
    func showActivityIndicator(uiView: UIView) {
        DispatchQueue.main.async {
            self.container = UIView()
            self.loadingView = UIView()
            let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            if let containerView = self.container , let loadView = self.loadingView {
                containerView.frame = uiView.frame
                containerView.center = uiView.center
                containerView.backgroundColor = self.UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
                containerView.tag = self.activityIndicatorTag
                loadView.frame = CGRect.init(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
                loadView.center = uiView.center
                loadView.backgroundColor = self.UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
                loadView.clipsToBounds = true
                loadView.layer.cornerRadius = 10
                
                activityIndicator.frame = CGRect.init(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
                activityIndicator.style = .large
                activityIndicator.center = CGPoint.init(x:loadView.frame.size.width / 2, y: loadView.frame.size.height / 2)
                
                loadView.addSubview(activityIndicator)
                containerView.addSubview(loadView)
                uiView.addSubview(containerView)
                activityIndicator.startAnimating()
            }
            
        } 
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        
        DispatchQueue.main.async {
            if let viewWithtag = uiView.viewWithTag(self.activityIndicatorTag) {
                viewWithtag.removeFromSuperview()
            }
        }
        
        
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func convertDateFormateString(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let formtedDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let dateVal = dateFormatter.string(from: formtedDate)
        return dateVal        
    }
}
