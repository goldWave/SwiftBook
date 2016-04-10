//
//  BookDetailViewController.swift
//  Book_Swift
//
//  Created by 任金波 on 16/4/3.
//  Copyright © 2016年 任金波. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var  bookDetail:[String:NSObject]? = nil
    var  infoHeight:CGFloat = 0.0
    
    
    
    private let detailTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "图书详情"
        print(bookDetail)
        self.initTableView ()
        
        // Do any additional setup after loading the view.
    }
    //     init(detailData: [String:NSObject]) {
    //        self.bookDetail = detailData
    //        super .init(coder: NSCoder)
    //    }
    func initTableView() {
        self.detailTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
        self.detailTableView.backgroundColor = UIColor.lightGrayColor()
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
        self.detailTableView.tableFooterView = UIView()
        self.detailTableView.registerClass(UITableViewCell.self , forCellReuseIdentifier: "originCell")
        self.view.addSubview(self.detailTableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath .row == 0 {
                var cell = tableView.dequeueReusableCellWithIdentifier("imageCell")
                if (cell == nil)
                {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "imageCell")
                }
                cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH + 120 )
                let imageView = UIImageView(frame: CGRectMake(0, 20, SCREEN_WIDTH, 140))
                imageView.contentMode  = UIViewContentMode.ScaleAspectFit
                cell?.contentView.addSubview(imageView)
                
                let imageArr = self.bookDetail!["images"] as! [String: NSObject]
                let imageStr = imageArr["medium"] as!  String
                imageView.sd_setImageWithURL( NSURL(string: imageStr), placeholderImage:UIImage(named: "23"))
                return cell!
            }
            if indexPath.row == 1 {
                var cell = tableView.dequeueReusableCellWithIdentifier("nameCell")
                if (cell == nil) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "nameCell")
                }
                cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: SCREEN_WIDTH + 120 )
                cell?.textLabel?.text = self.bookDetail!["title"] as? String
                cell?.textLabel?.font = UIFont.boldSystemFontOfSize(18)
                cell?.textLabel?.numberOfLines = 0
                return cell!
                
            }
            
            if indexPath.row == 2 {
                var cell = tableView.dequeueReusableCellWithIdentifier("countCell")
                if (cell == nil) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "countCell")
                }
                cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                let rating = self.bookDetail!["rating"] as! [String:NSObject]
                let aver = rating["average"] as! String
                let averInt = Double(aver)
                let backgroundView = UIView()
                backgroundView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 47)
                for i in 0...4 {
                    let starImage = UIImageView(frame: CGRectMake(CGFloat(20 + 34*i), 3, 30, 30))
                    if Double((i+1)*2) <= averInt  {
                        starImage.image = UIImage(named: "star_yes")
                    } else {
                        starImage.image = UIImage(named: "star_no")
                    }
                    backgroundView.addSubview(starImage)
                }
                
                let scoreLabel = UILabel(frame:  CGRectMake( 200 , 3 , SCREEN_WIDTH - 200 , 30))
                scoreLabel.text = rating["numRaters"] as! String + "人评分"
                backgroundView.addSubview(scoreLabel)
                cell?.contentView.addSubview(backgroundView)
                return cell!
            }
            if indexPath.row == 3 {
                var cell = tableView.dequeueReusableCellWithIdentifier("commentsCell")
                if (cell == nil) {
                    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "commentsCell")
                }
                let backgroundView = UIView()
                backgroundView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 60)
                let infoLabel = UILabel()
                //作者，出版社，出版日期
                let authors = self.bookDetail!["author"] as? [String]
                let author = authors?.joinWithSeparator("\\")
                let publisher = self.bookDetail!["publisher"] as! String
                let pubdate = self.bookDetail!["pubdate"] as! String
                infoLabel.text =  author! + "/" + publisher + "/" + pubdate
                infoLabel.font = UIFont.systemFontOfSize(15)
                infoLabel.numberOfLines  = 0
                let  infoSize:CGSize = infoLabel.sizeThatFits(CGSize(width: SCREEN_WIDTH - 30 , height: 999))
                self.infoHeight = infoSize.height
                infoLabel.frame = CGRect(x: 30 , y: 10, width: SCREEN_WIDTH - 30 , height: self.infoHeight)
                
                let commentsBtn = UIButton(frame: CGRect(x: 30, y: CGRectGetMaxY(infoLabel.frame) + 10 , width: 150, height: 30))
                commentsBtn.setTitle("评论", forState: UIControlState.Normal)
                commentsBtn.backgroundColor = UIColor.orangeColor()
                commentsBtn.layer.cornerRadius = 4
                
                let collectionBtn = UIButton(frame: CGRect(x: CGRectGetMaxX(commentsBtn.frame) + 10  , y: CGRectGetMaxY(infoLabel.frame) + 10 , width: 150, height: 30))
                collectionBtn.setTitle("收藏", forState: UIControlState.Normal)
                collectionBtn.backgroundColor = UIColor.orangeColor()
                collectionBtn.layer.cornerRadius = 4
                
                
                
                backgroundView.addSubview(infoLabel)
                backgroundView.addSubview(commentsBtn)
                backgroundView.addSubview(collectionBtn)
                cell?.contentView.addSubview(backgroundView)
                
                return cell!
                
            }
        }
        
            let cell = tableView.dequeueReusableCellWithIdentifier("originCell", forIndexPath: indexPath)
            cell.textLabel?.text = "5678"
            cell.detailTextLabel?.text = "bsbvj"
            return cell
        }
        
        
        func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            if  indexPath.section == 0 {
                if indexPath.row == 0 {
                    return 180
                }
                if indexPath.row == 3 {
                    return self.infoHeight + 60
                }
                
            }
            return 47
            
        }
}
