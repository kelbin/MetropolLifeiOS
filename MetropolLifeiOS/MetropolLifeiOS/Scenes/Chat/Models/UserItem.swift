//
//  UserItem.swift
//  MetropolLifeiOS
//
//  Created by Kelbinary on 27.03.2021.
//  Copyright © 2021 Kelbinary. All rights reserved.
//

import Foundation
import MessageKit

struct UserItem: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
