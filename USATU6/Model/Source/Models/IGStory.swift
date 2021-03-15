//
//  IGStory.swift
//
//  Created by Ranjith Kumar on 9/8/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

public class IGStory: Codable {
    // Note: To retain lastPlayedSnapIndex value for each story making this type as class
    public var snapsCount: Int = 0
    public var snaps: [IGSnap] = []
    public var internalIdentifier: String = ""
    public var union: String = ""
    public var unionImage: String = ""
    public var lastUpdated: Int = 0
    public var user: IGUser
    var lastPlayedSnapIndex = 0
    var isCompletelyVisible = false
    var isCancelledAbruptly = false
    
    enum CodingKeys: String, CodingKey {
        case snapsCount = "snaps_count"
        case snaps = "snaps"
        case internalIdentifier = "id"
        case lastUpdated = "last_updated"
        case union = "union"
        case unionImage = "unionImage"
        case user = "user"
    }
}

extension IGStory: Equatable {
    public static func == (lhs: IGStory, rhs: IGStory) -> Bool {
        return lhs.internalIdentifier == rhs.internalIdentifier
    }
}
