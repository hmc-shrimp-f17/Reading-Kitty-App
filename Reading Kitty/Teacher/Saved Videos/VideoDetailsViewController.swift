//
//  VideoDetailsViewController.swift
//  Reading Kitty
//
//  Created by cssummer18 on 6/13/18.
//  Copyright © 2018 cssummer18. All rights reserved.
//

import UIKit
import AVKit

class VideoDetailsViewController: UIViewController {
    //////// Figure out export video button ////////
    /********** LOCAL VARIABLES **********/
    // Label
    @IBOutlet weak var videoLabel: UILabel!
    
    // Textbox
    @IBOutlet weak var feedbackBox: UITextView!
    
    // Reference to levels, books, and devices
    var modelController = ModelController()
    
    /********** VIEW FUNCTIONS **********/
    // When view controller appears, set the correct video title as the header and the correct feedback as the infobox
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set correct video title
        videoLabel.text = modelController.getVideoTitle()
        
        // Set correct feedback
        feedbackBox.text = modelController.getVideo().feedback
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /********** SEGUE FUNCTIONS **********/
    // When user clicks the back button, it send them to the SavedVideos scene
    @IBAction func backButton(_ sender: Any) {
        // Go to SavedVideos
        self.performSegue(withIdentifier: "SavedVideos", sender: self)
    }
    
    // When user clicks the delete button, it removes the video from the saved videos list and sends them to the SavedVideos scene
    @IBAction func deleteButton(_ sender: Any) {
        // Delete video
        print(modelController.getVideoTitles())
        modelController.deleteVideo()
        print(modelController.getVideoTitles())
        
        // Go to SavedVideos
        self.performSegue(withIdentifier: "SavedVideos", sender: self)
    }
    
    // When user clicks the play button, it plays the video and send them to the Player scene
    @IBAction func playVideo(_ sender: Any) {
        // Get video
        let currentVideo = modelController.getVideo()
        
        // Play video
        if let path = Bundle.main.path(forResource: currentVideo.file, ofType: "mp4") {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }
    
    // Passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Update the modelController in SavedVideos
        if segue.destination is SavedVideosViewController {
            let Destination = segue.destination as? SavedVideosViewController
            Destination?.modelController = modelController
        }
    }
    

}
