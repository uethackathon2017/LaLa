//
//  WhatNewsViewController.swift
//  Hackathon_UET
//
//  Created by Anh Tuan on 3/5/17.
//  Copyright © 2017 Anh Tuan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WhatNewsViewController: BaseViewController {
    @IBOutlet weak var tbl : UITableView!
    var listShow = [News]()    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(WhatNewsViewController.reloadData(notification:)), name: NSNotification.Name.init("Menu0"), object: nil)
        tbl.register(UINib.init(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "NewTableViewCell")
        tbl.estimatedRowHeight = 100
        tbl.rowHeight = UITableViewAutomaticDimension
        self.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func loadData() {
        self.showLoadingHUD()
        Alamofire.request(URL_DEFINE.home_post, method: .get, parameters: nil).authenticate(user: "admin", password: "123456").responseJSON { (response) in
            let jsondata = JSON.init(data: response.data!)
            NSLog("\(jsondata)")
            for item in jsondata.array! {
                let new = News(json: item)
                self.listShow.append(new)
            }
            self.hideLoadingHUD()
            self.tbl.reloadData()
        }
    }
    
    func reloadData(notification : Notification) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setLikeforIndex(index : IndexPath, status : Bool) {
        
    }
    
    func setDisLikeForIndex(index : IndexPath, status : Bool){
        
    }
    func favForIndex(index : IndexPath, status : Bool){
        
    }
}
extension WhatNewsViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listShow.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as! NewTableViewCell
        cell.object = listShow[indexPath.row]
        cell.setData(new: listShow[indexPath.row])
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailPost = DetailPostViewController(nibName: "DetailPostViewController", bundle: nil) as! DetailPostViewController
        detailPost.delegate = self
        detailPost.dataNews = self.listShow[indexPath.row]
        self.navigationController?.pushViewController(detailPost, animated: true)
    }

}
extension WhatNewsViewController : DetailPostDelegate {
    func likeTouch(index: IndexPath, status: Bool) {
        
    }
    func favTouch(index: IndexPath, status: Bool) {
        
    }
    func disLikeTouch(index: IndexPath, status: Bool) {
        
    }
}
extension WhatNewsViewController : DelegateNewCell {
    func likeTouchUp(cell : NewTableViewCell , status : Bool){
        
    }
    func dislikeTouchUp(cell : NewTableViewCell , status : Bool){
        
    }
    func favTouchUp(cell : NewTableViewCell , status : Bool){
        
    }
    func commentTouchUp(cell : NewTableViewCell){
        
    }
    func selectImage(cell : NewTableViewCell, index : Int){
        let index = tbl.indexPath(for: cell)
        let slidePhotoVC = SilderPhotoViewController(nibName: "SilderPhotoViewController", bundle: nil)
        slidePhotoVC.listPhotoItem = self.listShow[(index?.row)!].imagePath
        self.present(slidePhotoVC, animated: true, completion: nil)
        // = self.listShow[index?.row].ima
    }
}