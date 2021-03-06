//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 5/1/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let image: UIImage
    
    init(name: SettingName, image: UIImage) {
        self.name = name
        self.image = image
    }
}

enum SettingName: String {
    case Cancel = "Cancel"
    case Terms = "Terms & privacy policy"
    case Feedback = "Send Feedback"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Settings = "Settings"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Setting] = [
         Setting(name: .Settings, image: #imageLiteral(resourceName: "settings")),
         Setting(name: .Terms, image: #imageLiteral(resourceName: "privacy")),
         Setting(name: .Feedback, image: #imageLiteral(resourceName: "feedback")),
         Setting(name: .Help, image: #imageLiteral(resourceName: "help")),
         Setting(name: .SwitchAccount, image: #imageLiteral(resourceName: "switch_account")),
         Setting(name: .Cancel, image: #imageLiteral(resourceName: "cancel"))
    ]
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.row]
        return cell
    }
    
    
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
   
    
    let blackView = UIView()
    
    func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            var safetyAreaHeight: CGFloat = 0
            
            if #available(iOS 11.0, *){
                safetyAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            }
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(handleDissmiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight + safetyAreaHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func handleDissmiss() {
        closeSettings(setting: nil)
    }
    
    func closeSettings(setting: Setting?) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }) { (completed: Bool) in
            if let setting = setting, setting.name != .Cancel {
                self.homeController?.showController(for: setting)
            }
        }
    }
    
    var homeController: HomeController?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        closeSettings(setting: settings[indexPath.row])
        print(setting.name)
    }
}
