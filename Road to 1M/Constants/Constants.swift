//
//  Constants.swift
//  Road to 1M
//
//  Version 1.5v *Alpha*
//  Copyright © 2018 1M. All rights reserved.
//

import Firebase
import FirebaseDatabase
import UIKit

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseChats = databaseRoot.child("chats")
    }
}
