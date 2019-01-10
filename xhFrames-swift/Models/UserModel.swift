//
//  UserModel.swift
//  xhFrames-swift
//
//  Created by hui xiang on 2018/12/11.
//  Copyright © 2018 xianghui. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var userId: Int?
    var nickName: String?
    var avatar: String?
}


class AccountModel: NSObject {
    var user: UserModel?
    var token: String?
}
