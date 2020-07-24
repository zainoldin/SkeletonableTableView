//
//  RowType.swift
//  SkeletonableTableView
//
//  Created by Almas Zainoldin on 7/16/20.
//  Copyright © 2020 crococoders. All rights reserved.
//

import Foundation

enum SectionType {
    case none(rows: [NoneSectionRowType])
    case regular(title: String, rows: [RagularSectionRowType])
}

enum NoneSectionRowType {
    case profile
    case circled
}

enum RagularSectionRowType {
    case option
}

