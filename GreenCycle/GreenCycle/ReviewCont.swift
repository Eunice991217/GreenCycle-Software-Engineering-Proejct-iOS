//
//  ReviewCont.swift
//  GreenCycle
//
//  Created by 김민경 on 12/2/23.
//

import UIKit

class ReviewCont: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate=self
        TableView.dataSource=self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDatas.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell() }
        
        cell.basicImage.image = UserDatas[indexPath.row].basicImage
        cell.userName.text=UserDatas[indexPath.row].name
        cell.comment.text=UserDatas[indexPath.row].comment
                
        return cell // 테이블뷰에 넣을 셀
                
    }
    
    let UserDatas: [UserdataModel] = [
        UserdataModel(
            basicImage: UIImage(named: "recycle"),
            name: "Eunice",
            comment: "음 좋네용"
        ),
        UserdataModel(
            basicImage: UIImage(named: "recycle"),
            name: "KMK",
            comment: "음 별루네용"
        ),
    ]
}

struct UserdataModel {
    let basicImage: UIImage? // 에러방지 : 옵셔널 처리
    let name: String
    let comment: String
}


