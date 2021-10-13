//
//  ArtistWorkCell.swift
//  PartyBooking
//
//  Created by MAC on 21/09/2021.
//  Copyright © 2021 MAC. All rights reserved.
//


import UIKit
import AVKit

class ArtistWorkCell: UICollectionViewCell {

    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var videoPlayView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var playView: UIView!

    static var videoPlayer: AVPlayer? = nil
    var videoPlayerLayer: AVPlayerLayer? = nil
    var isVideoPlaying = false
    var openDetailsAction: (() -> Void)? = nil
    var openFullScreenVideo: (() -> Void)? = nil

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self,selector: #selector(playerItemDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: ArtistWorkCell.videoPlayer?.currentItem)
    }

    @objc func playerItemDidReachEnd(notification: NSNotification) {
        ArtistWorkCell.videoPlayer?.seek(to: CMTime.zero)
        ArtistWorkCell.videoPlayer?.play()
    }
    
    func config(imageURL: String, videoURL: String) {
        if imageURL != "" {
            self.artistImageView.isHidden = false
            self.playView.isHidden = true
            ArtistWorkCell.videoPlayer?.pause()
           guard let url = URL(string: "https://partybooking.dtagdev.com/" + imageURL) else  { return }
            self.artistImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "aasx"))
        }
        if videoURL != "" {
            self.artistImageView.isHidden = true
            self.playView.isHidden = false
            guard let videoURL = URL(string: videoURL) else { return }
            ArtistWorkCell.videoPlayer = AVPlayer(url: videoURL)
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    self.videoPlayerLayer = AVPlayerLayer(player: ArtistWorkCell.videoPlayer)
                    self.videoPlayerLayer?.videoGravity = .resizeAspect
                    self.videoPlayerLayer?.cornerRadius = 5
                    self.videoPlayerLayer?.masksToBounds = true
                    self.videoPlayerLayer?.frame = self.videoPlayView.layer.bounds
                    self.videoPlayView.layer.addSublayer(self.videoPlayerLayer!)
                    ArtistWorkCell.videoPlayer?.play()
                    ArtistWorkCell.videoPlayer?.isMuted = true
                }
            }
            isVideoPlaying = true
        }
    
    }//END of Config
    
    @IBAction func PlayAction(_ sender: UIButton) {
        openFullScreenVideo?()
    }
    @IBAction func GoForDetailsAction(_ sender: UIButton) {
        openDetailsAction?()
    }
    
 
    
}
