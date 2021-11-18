import UIKit
import AVFoundation

class DetailViewController: UIViewController {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var btnStatStopSpeak: UIButton!
  @IBOutlet weak var detailtxtview: UITextView!
   
    let speechSynthesizer = AVSpeechSynthesizer()
    var isspeak = Bool()

    var detailWord: Word? {
    didSet {
      configureView()
    }
  }
  
  func configureView() {
    if let detailWord = detailWord {
        if let detailDescriptionLabel = detailDescriptionLabel{
          detailDescriptionLabel.text = detailWord.category
            let label = UILabel()
            label.text = detailWord.name
            label.textAlignment = .left
            label.font = UIFont.boldSystemFont(ofSize: 20)
            self.navigationItem.titleView = label
            detailtxtview.text = detailWord.detail
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    isspeak = true
  }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    @IBAction func btnStatStopSpeak(_ sender: Any)
    {
        if isspeak {
            btnStatStopSpeak.setTitle("Speak", for: .normal)
            let speechUtterance = AVSpeechUtterance(string: (detailWord?.name)!)
            speechSynthesizer.speak(speechUtterance)
            isspeak = false
        }
        else{
            btnStatStopSpeak.setTitle("Speak", for: .normal)
            speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            isspeak = true
        }
    }
}

