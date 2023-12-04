//
//  ReviewCont.swift
//  GreenCycle
//
//  Created by 김민경 on 12/2/23.
//

import UIKit
import Alamofire

class ReviewCont: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    
    var centerInfoId:Int?
    var reviews: [ReviewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate=self
        TableView.dataSource=self
        
        print(reviews)
        
        fetchReviews()

    }
    
    func fetchReviews() {
        guard let centerInfoId = centerInfoId else {
            return
        }

        let apiUrl = "http://localhost:8080/api/review/\(centerInfoId)"

        AF.request(apiUrl, method: .get).responseDecodable(of: [ReviewModel].self) { [weak self] response in
            guard let self = self else { return }

            switch response.result {
            case .success(let reviews):
                self.reviews = reviews
                self.TableView?.reloadData() // 테이블 뷰를 다시 로드
            case .failure(let error):
                print("Error fetching reviews: \(error)")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(reviews.count)
        return reviews.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.userName.text = reviews[indexPath.row].userName
        cell.comment.text = reviews[indexPath.row].content
        
        return cell
    }
    
}

struct ReviewModel: Decodable {
    let userName: String
    let content: String
}



