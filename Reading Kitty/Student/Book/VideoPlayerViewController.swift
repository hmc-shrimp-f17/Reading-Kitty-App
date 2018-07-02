//
//  VideoPlayerViewController.swift
//  Reading Kitty
//
//  Created by cssummer18 on 6/29/18.
//  Copyright © 2018 cssummer18. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    /********** LOCAL VARIABLES **********/
    // Audio, text, and video
    var audioURL: URL = URL(fileURLWithPath: "")
    var allText:NSMutableAttributedString = NSMutableAttributedString(string: "")
    var videoFileName: String = ""
    
    // Loading icon
    var makeNewVideo: Bool = false
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    // Buttons
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    // Temporary timer
    var timer: Timer!
    var invalidated: Bool = false

    // Reference to data
    var modelController:ModelController = ModelController()
    
    /********** VIEW FUNCTIONS **********/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("in the player")
        
        if makeNewVideo {
            print("make new")
            // Show loading icon, and hide play and done buttons
            loadingIcon.isHidden = false
            loadingIcon.hidesWhenStopped = true
            playButton.isEnabled = false
            playButton.isHidden = true
            doneButton.isEnabled = false
            doneButton.isHidden = true
        } else {
            // Show play and done buttons, and hide loading icon
            print("hmm")
            loadingIcon.isHidden = true
            loadingIcon.hidesWhenStopped = true
            playButton.isEnabled = true
            playButton.isHidden = false
            doneButton.isEnabled = true
            doneButton.isHidden = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if makeNewVideo {
            print("Start loading")
            // Start loading icon
            loadingIcon.startAnimating()
            
            // Reset timer
            if timer != nil {
                timer.invalidate()
                timer = nil
                invalidated = true
            }
            
            // Start loading timer
            invalidated = false
            timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(timerOff), userInfo: nil, repeats: false)
        }
    }
    
    @objc func timerOff() {
        print("should invalidate")
        timer.invalidate()
        timer = nil
        invalidated = true
        
        // Stop loading icon
        loadingIcon.stopAnimating()
        
        print("make video")
        // Make video
        makeVideo()
        
        print("show buttons")
        // Show play and done buttons
        playButton.isEnabled = true
        playButton.isHidden = false
        doneButton.isEnabled = true
        doneButton.isHidden = false
    }
    
    func makeVideo() {
        // Get audio and text
        audioURL = modelController.audioURL
        for text in modelController.allText {
            allText.append(text)
        }
        
        // import video into data set
        
        // get videofile
        videoFileName = "Emperor's New Clothes"
        print("video made")
        makeNewVideo = false
    }
    
    @IBAction func playButton(_ sender: Any) {
        if let path = Bundle.main.path(forResource: videoFileName, ofType: "mp4") {
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }

    
    /********** SEGUE FUNCTIONS **********/
    @IBAction func doneButton(_ sender: Any) {
        // Save video
        modelController.saveVideo(feedback: "Good job.", file: "Emperor's New Clothes")
        print("saved video")
        
        // Go to the Welcome scene
        self.performSegue(withIdentifier: "Welcome", sender: self)
    }
    
    // Passing data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Update the modelController in the Welcome scene.
        if segue.destination is ViewController {
            // This is the first section and the first question.
            modelController.mySection = 0
            modelController.myQuestion = 0
            
            // Reset values
            modelController.currentRanges = []
            modelController.currentAttributes = []
            modelController.allText = []
            modelController.allRanges = []
            modelController.allAttributes = []
            
            // Update the modelController.
            let Destination = segue.destination as? ViewController
            Destination?.modelController = modelController
        }
    }
}
