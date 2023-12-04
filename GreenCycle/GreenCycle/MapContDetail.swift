//
//  MapContDetail.swift
//  GreenCycle
//
//  Created by 김민경 on 12/2/23.
//

import UIKit
import Alamofire

class MapContDetail: UIViewController {
    
    var selectedMarkerId: Int?
    var userName: String?
    var userInfoId: Int?
    
    @IBOutlet weak var reviewTextField: UIView!
    @IBOutlet weak var textField: UITextView!
    
    
    @IBOutlet weak var centerName: UILabel!
    @IBOutlet weak var centerLocation: UILabel!
    @IBOutlet weak var centerTime: UILabel!
    @IBOutlet weak var adminName: UILabel!
    @IBOutlet weak var centerNumber: UILabel!
    @IBOutlet weak var centerItems: UILabel!
    
    
    @IBOutlet weak var createBtn: UIView!
    @IBOutlet weak var readBtn: UIView!
    
    
    @IBAction func writeBtnDidTap(_ sender: Any) {
        
        
        
        guard let selectedMarkerId = selectedMarkerId,
              let userName = userName,
              let content = textField.text else {
            return
        }

        let apiUrl = "http://localhost:8080/api/createReview"

        let reviewModel = reviewModelElement(
            centerInfoId: selectedMarkerId,
            userInfoId: userInfoId!,  // You may need to replace this with the actual userInfoId
            userName: userName,
            content: content
        )

        AF.request(apiUrl, method: .post, parameters: reviewModel, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Review created successfully: \(value)")
            case .failure(let error):
                print("Error creating review: \(error)")
            }
        }
        
    }
    
    
    @IBAction func readBtnDidTap(_ sender: Any) {
        guard let ReviewCont = self.storyboard?.instantiateViewController(withIdentifier: "ReviewCont") as? ReviewCont else{return}
        present(ReviewCont, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTextField.layer.cornerRadius = 20
        reviewTextField.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        createBtn.layer.cornerRadius = 20
        createBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        readBtn.layer.cornerRadius = 20
        readBtn.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        textField.delegate = self
                
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        textField.text = "Please write a review"
        textField.textColor = UIColor.lightGray
        
        print("id : \(selectedMarkerId!)")
        
        
        if let selectedMarkerId = selectedMarkerId {
            let apiUrl = "http://localhost:8080/api/mapDetail/\(selectedMarkerId)"

            AF.request(apiUrl, method: .get).responseDecodable(of: detailModelElement.self) { response in
                switch response.result {
                case .success(let detailModel):
                    self.centerName.text = detailModel.name
                    self.centerLocation.text = detailModel.location
                    self.centerTime.text = "\(detailModel.startTime)AM - \(detailModel.endTime)PM"
                    
                    self.adminName.text = detailModel.admin ?? "장정민"
                    self.centerNumber.text = detailModel.number ?? "02-345-3827"
                    
                    self.centerItems.text = detailModel.items
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textField.resignFirstResponder()
    }

}

extension MapContDetail: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textField.text.isEmpty {
            textField.text =  "Please write a review"
            textField.textColor = UIColor.lightGray
        }

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
}
