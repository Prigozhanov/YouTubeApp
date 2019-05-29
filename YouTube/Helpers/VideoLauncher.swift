//
//  VideoLauncher.swift
//  YouTube
//
//  Created by Uladzimir Pryhazhanau on 5/29/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    
    let pausePlayButton: UIButton = {
       let button = UIButton(type: .system)
        let image = #imageLiteral(resourceName: "pause")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var player: AVPlayer?
    
    var isPlaying = false
    
    @objc func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
       
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        backgroundColor = .black
    }
    
    private func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.play()
            isPlaying = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        
        if let keyWindow = UIApplication.shared.keyWindow {
            var safeArea = CGFloat(0)
            if #available(iOS 11.0, *) {
                safeArea = CGFloat(keyWindow.safeAreaInsets.top)
            }
            
            
            let view = UIView()
            view.backgroundColor = .white
            
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: keyWindow.frame.width * 9 / 16)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = CGRect(x: 0, y: 0 + safeArea, width: keyWindow.frame.width, height: keyWindow.frame.height - safeArea)
            }) { (completed) in
                // later
            }
            
        }
        

    }
    
}
