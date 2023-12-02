//
//  MapContDetail.swift
//  GreenCycle
//
//  Created by 김민경 on 12/2/23.
//

import UIKit

class MapContDetail: UIViewController {
    
    
    @IBOutlet weak var reviewTextField: UIView!
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTextField.layer.cornerRadius = 20
        reviewTextField.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        
        textField.delegate = self
                
        //처음 화면이 로드되었을 때 플레이스 홀더처럼 보이게끔 만들어주기
        textField.text = "Please write a review"
        textField.textColor = UIColor.lightGray
        
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
