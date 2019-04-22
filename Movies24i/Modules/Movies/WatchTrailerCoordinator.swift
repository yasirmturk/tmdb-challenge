//
//  WatchTrailerCoordinator.swift
//  Movies24i
//
//  Created by Yasir M Turk on 22/04/2019.
//  Copyright © 2019 yasirmturk. All rights reserved.
//

import MUIKit
import AVKit
import XCDYouTubeKit

class WatchTrailerCoordinator: Coordinator {

    // MARK: - Properties
    var children = [Coordinator]()
    var root: UIViewController!

    weak var parent: Coordinator?

    var video: Video

    init(_ controller: UIViewController, for video: Video) {
        self.root = controller
        self.video = video
    }

    func start() {
        // Register for notification
        prepareNotifications()
        // Present Player
        let player = AVPlayerViewController()
        root.present(player, animated: true, completion: nil)
        // Load YouTube video and play when ready
        loadYouTubeVideo(video.key, in: player)
    }

    func loadYouTubeVideo(_ key: String, in playerVC: AVPlayerViewController) {
        XCDYouTubeClient.default().getVideoWithIdentifier(key) { [weak self, weak playerVC] youTubeVideo, _ in
            if let v = youTubeVideo,
                let url = v.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming]
                    ?? v.streamURLs[XCDYouTubeVideoQuality.HD720.key]
                    ?? v.streamURLs[XCDYouTubeVideoQuality.medium360.key]
                    ?? v.streamURLs[XCDYouTubeVideoQuality.small240.key] {
                // print(url)
                let player = AVPlayer(url: url)
                playerVC?.player = player
                player.play()
            } else {
                // print(error)
                self?.dismiss()
            }
        }
    }

    func dismiss() {
        root.dismiss(animated: true) {
            self.parent?.childDidFinish(self)
        }
    }

    func prepareNotifications() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(playerItemDidReachEnd),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: nil)
    }

    // Notification Handling
    @objc
    func playerItemDidReachEnd(notification: NSNotification) {
        dismiss()
    }

    // Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
