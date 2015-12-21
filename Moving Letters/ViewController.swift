



import UIKit

class ViewController: UIViewController {
    
    //MARK: - ViewLifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blueColor();
        addLetterView()
        addTapRecognizer()
    }
    
    //MARK: - Private
    
    var letterView = LetterView(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
    var letters = [B, A, B, A, B, A]
    
    func addLetterView() {
        view.addSubview(letterView)
    }
    
    func addTapRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "tapReceived")
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    func tapReceived() {
        letterView.drawLetter(letters.first!)
        letters.removeFirst()
    }

}

