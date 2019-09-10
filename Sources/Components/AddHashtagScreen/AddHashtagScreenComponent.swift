//
//  Created by Dmitry Ivanenko on 05/08/2019.
//  Copyright © 2019 Groshy. All rights reserved.
//

import UIKit
import Command


final class AddHashtagScreenComponent: BaseComponent<AddHashtagScreenConnector> {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tagsContainerScrollView: UIScrollView!
    @IBOutlet weak var tagsContainerStackView: UIStackView!
    @IBOutlet weak var upperTagsStackView: UIStackView!
    @IBOutlet weak var lowerTagsStackView: UIStackView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    // MARK: - Lifecycle
    
    override func setup() {
        super.setup()
        
        textField.becomeFirstResponder()
        textField.tintColor = Colors.black
        textField.textColor = Colors.black
    }
    
    override func render(old oldProps: AddHashtagScreenPropsState?) {
        let tags = splitTags(props.hashtags, byGroups: 2)
        let upperHashtags: [Hashtag]
        let lowerHashtags: [Hashtag]

        if tags.count >= 1 {
            upperHashtags = tags[0]
        } else {
            upperHashtags = []
        }

        if tags.count >= 2 {
            lowerHashtags = tags[1]
        } else {
            lowerHashtags = []
        }

        let onTapCommand: CommandOf<Hashtag> = CommandOf { [unowned self] hashtag in
            self.props.saveCommand.execute(with: hashtag)
            self.close(self)
        }
        
        upperTagsStackView.removeArrangedSubviews()
        upperTagsStackView.addArrangedSubviews(upperHashtags.map({ hashtag in
            let view = HashtagView()
            view.setup(hashtag: hashtag, onTap: onTapCommand.bound(to: hashtag))
            return view
        }))
        
        lowerTagsStackView.removeArrangedSubviews()
        lowerTagsStackView.addArrangedSubviews(lowerHashtags.map({ hashtag in
            let view = HashtagView()
            view.setup(hashtag: hashtag, onTap: onTapCommand.bound(to: hashtag))
            return view
        }))
    }
    
    
    // MARK: - IBActions
    
    @IBAction func close(_ sender: Any) {
        textField.resignFirstResponder()
        props.dismissCommand.execute(with: self)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = textField.text, !title.isEmpty else {
            return
        }
        
        let hashtag = Hashtag(id: .init(rawValue: UUID()), title: title)
        props.saveCommand.execute(with: hashtag)
        close(sender)
    }

}


// MARK: - Split tags

extension AddHashtagScreenComponent {

    private func splitTags(_ tags: [Hashtag], byGroups groupsCount: Int) -> [[Hashtag]] {
        var groupsCombined: [Int: String] = [:]
        var groups: [Int: [Hashtag]] = [:]
        
        for i in 0..<groupsCount {
            groupsCombined[i] = ""
            groups[i] = []
        }
        
        for tag in tags {
            let nextGroupIndex = findNextGroupIndex(group: groupsCombined)
            groupsCombined[nextGroupIndex] = groupsCombined[nextGroupIndex]! + tag.title
            groups[nextGroupIndex]?.append(tag)
        }
        
        return Array(groups.values)
    }
    
    private func findNextGroupIndex(group: [Int: String]) -> Int {
        let info = group.min { (a, b) -> Bool in
            if a.value.count == b.value.count {
                return a.key < b.key
            } else {
                return a.value.count < b.value.count
            }
        }
        
        return info?.key ?? 0
    }
    
}
