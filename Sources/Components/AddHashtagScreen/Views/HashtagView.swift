//
//  Created by Dmitry Ivanenko on 06/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


final class HashtagView: NibView {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var hashtagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - Private Properties
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gr = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        gr.numberOfTapsRequired = 1
        return gr
    }()
    
    private var onTap: Command?
    
    
    
    // MARK: - Lifecycle
    
    override func xibSetup() {
        super.xibSetup()
        
        hashtagLabel.font = Fonts.Rubik.Bold(size: 17)
        hashtagLabel.textColor = Colors.blue
        
        titleLabel.font = Fonts.Rubik.Bold(size: 17)
        titleLabel.textColor = Colors.black
        
        view.backgroundColor = Colors.darkWhite
        addGestureRecognizer(tapGesture)
        
        layer.cornerRadius = 4
        layer.masksToBounds = true
    }
    

    // MARK: - Public Methods
    
    func setup(hashtag: Hashtag, onTap: Command?) {
        titleLabel.text = hashtag.title
        self.onTap = onTap
    }
    
    
    // MARK: - Private Methods
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        onTap?.execute()
    }
    
}
