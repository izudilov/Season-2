//
//  ByGroup.swift
//  1l_ZudilovIlya
//
//  Created by user179996 on 14.11.2020.
//  Copyright © 2020 izudilov. All rights reserved.
//

import UIKit

struct GroupedSection<SectionItem : Hashable, RowItem> {

    var sectionItem : SectionItem
    var rows : [RowItem]

    static func group(rows : [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedSection<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: rows, by: criteria)
        return groups.map(GroupedSection.init(sectionItem:rows:))
    }

}
