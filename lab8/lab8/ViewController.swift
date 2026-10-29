import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var progressView: UIProgressView!
    var audioPlayer: AVAudioPlayer?
    var currentTrackIndex = 0
    var isPlaying = false
    var progressTimer: Timer?
    let tracks = TrackLibrary.tracks
    func loadAndPlayTrack(at index: Int) {
        let track = tracks[index]
        titleLabel.text = track.title
        artistLabel.text = track.artist
        coverImageView.image = UIImage(named: track.coverImageName)
        do {
            guard let url = Bundle.main.url(
                forResource: track.fileName,
                withExtension: "mp3"
            ) else {
                print("Audio file not found: \(track.fileName)")
                return
            }
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            progressView.progress = 0
            startProggresTimer()
            if isPlaying {
                audioPlayer?.play()
            }
        }
        catch {
            print("Error loading audio: \(error)")
        }
    }
    @IBAction func playPauseTapped(_ sender: UIButton) {
        if isPlaying {
            audioPlayer?.pause()
            playButton.setImage(
                UIImage(systemName: "play.fill"),
                for: .normal
            )
        } else {
            audioPlayer?.play()
            playButton.setImage(
                UIImage(systemName: "pause.fill"),
                for: .normal
            )
        }
        isPlaying.toggle()
    }
    @IBAction func previousTapped(_ sender: UIButton) {
        currentTrackIndex = (tracks.count + currentTrackIndex - 1) % tracks.count
        loadAndPlayTrack(at: currentTrackIndex)
    }
    @IBAction func nextTapped(_ sender: UIButton) {
        currentTrackIndex = (currentTrackIndex + 1) % tracks.count
        loadAndPlayTrack(at: currentTrackIndex)
    }
    func audioPlayerDidFinishPlaying(
        _ player: AVAudioPlayer,
        successfully flag: Bool
    ) {
        currentTrackIndex = (currentTrackIndex + 1) % tracks.count
        loadAndPlayTrack(at: currentTrackIndex)
    }
    deinit {
        progressTimer?.invalidate()
    }
    func startProggresTimer(){
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(
            withTimeInterval: 0.5,
            repeats: true
        ){ [weak self] _ in
            guard let self = self,
                  let player = self.audioPlayer,
                  player.duration > 0
            else {
                return
            }
            self.progressView.progress =
                Float(player.currentTime / player.duration)
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndPlayTrack(at: currentTrackIndex)
        // Do any additional setup after loading the view.
    }


}

