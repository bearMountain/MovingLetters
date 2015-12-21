



import UIKit

class ViewController: UIViewController {
    
    //MARK: - ViewLifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .blueColor();
        addLetterView()
    }
    
    //MARK: - Private
    
    func addLetterView() {
        let letterView = LetterView(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        view.addSubview(letterView)
    }

}

