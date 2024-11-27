//
//  TestPageViewController.swift
//  RentCar
//
//  Created by beyza nur on 27.11.2024.
//

import UIKit

class TestPageViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bottonView: UILabel!
    @IBOutlet weak var resimButton: UIButton!
    
    //butonlar
    @IBOutlet weak var buton11: UIButton!
    @IBOutlet weak var buton12: UIButton!
    
    @IBOutlet weak var buton21: UIButton!
    @IBOutlet weak var buton22: UIButton!
    
    @IBOutlet weak var buton31: UIButton!
    @IBOutlet weak var buton32: UIButton!
    
    @IBOutlet weak var buton41: UIButton!
    @IBOutlet weak var buton42: UIButton!
    
    @IBOutlet weak var buton51: UIButton!
    @IBOutlet weak var buton52: UIButton!
    
    @IBOutlet weak var buton61: UIButton!
    @IBOutlet weak var buton62: UIButton!
    
    var buton2Dolu=true
    var buton4Dolu=true
    var buton6Dolu=true
    var buton8Dolu=true
    var buton10Dolu=true
    var buton12Dolu=true
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 10
        bottonView.layer.cornerRadius = 10
        resimButton.layer.cornerRadius = 10
    }
    
    @IBAction func buton11Clicked(_ sender: Any) {
        if(buton2Dolu==true){
            buton11.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton12.setImage(UIImage(systemName: "circle"), for: .normal)
            buton2Dolu=false}
        else if(buton2Dolu==false){
                buton11.setImage(UIImage(systemName: "circle.fill"), for: .normal)
                buton12.setImage(UIImage(systemName: "circle"), for: .normal)
                buton2Dolu=false}
    }
    @IBAction func buton12Clicked(_ sender: Any) {
        if(buton2Dolu==false){
            buton11.setImage(UIImage(systemName: "circle"), for: .normal)
            buton12.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton2Dolu=true}
        else  if(buton2Dolu==true){
            buton11.setImage(UIImage(systemName: "circle"), for: .normal)
            buton12.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton2Dolu=true}
    }
    
    @IBAction func buton21Clicked(_ sender: Any) {
        if(buton4Dolu==true){
            buton21.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton22.setImage(UIImage(systemName: "circle"), for: .normal)
            buton2Dolu=false}
        else  if(buton4Dolu==false){
            buton21.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton22.setImage(UIImage(systemName: "circle"), for: .normal)
            buton2Dolu=false}
    }
    
    @IBAction func buton22Clicked(_ sender: Any) {
        if(buton4Dolu==false){
            buton21.setImage(UIImage(systemName: "circle"), for: .normal)
            buton22.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton2Dolu=true}
        else if(buton4Dolu==true){
            buton21.setImage(UIImage(systemName: "circle"), for: .normal)
            buton22.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton2Dolu=true}
    }
    
    @IBAction func buton31Clicked(_ sender: Any) {
        if(buton6Dolu==true){
            buton31.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton32.setImage(UIImage(systemName: "circle"), for: .normal)
            buton6Dolu=false}
        else  if(buton6Dolu==false){
            buton31.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton32.setImage(UIImage(systemName: "circle"), for: .normal)
            buton6Dolu=false}
    }
    
    @IBAction func buton32Clicked(_ sender: Any) {
        if(buton6Dolu==false){
            buton31.setImage(UIImage(systemName: "circle"), for: .normal)
            buton32.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton6Dolu=true}
        else if(buton6Dolu==true){
            buton31.setImage(UIImage(systemName: "circle"), for: .normal)
            buton32.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton6Dolu=true}
    }
    
    @IBAction func buton41Clicked(_ sender: Any) {
        if(buton8Dolu==true){
            buton41.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton42.setImage(UIImage(systemName: "circle"), for: .normal)
            buton8Dolu=false}
        else  if(buton8Dolu==false){
            buton41.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton42.setImage(UIImage(systemName: "circle"), for: .normal)
            buton8Dolu=false}
    }
    
    @IBAction func buton42Clicked(_ sender: Any) {
        if(buton8Dolu==false){
            buton41.setImage(UIImage(systemName: "circle"), for: .normal)
            buton42.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton8Dolu=true}
        else if(buton8Dolu==true){
            buton41.setImage(UIImage(systemName: "circle"), for: .normal)
            buton42.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton8Dolu=true}
    }
    @IBAction func buton51Clicked(_ sender: Any) {
        if(buton10Dolu==true){
            buton51.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton52.setImage(UIImage(systemName: "circle"), for: .normal)
            buton10Dolu=false}
        else  if(buton10Dolu==false){
            buton51.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton52.setImage(UIImage(systemName: "circle"), for: .normal)
            buton10Dolu=false}
    }
    
    @IBAction func buton52Clicked(_ sender: Any) {
        if(buton10Dolu==false){
            buton51.setImage(UIImage(systemName: "circle"), for: .normal)
            buton52.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton10Dolu=true}
        else if(buton10Dolu==true){
            buton51.setImage(UIImage(systemName: "circle"), for: .normal)
            buton52.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton10Dolu=true}
    }
    
    @IBAction func buton61Clicked(_ sender: Any) {
        if(buton12Dolu==true){
            buton61.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton62.setImage(UIImage(systemName: "circle"), for: .normal)
            buton12Dolu=false}
        else  if(buton12Dolu==false){
            buton61.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton62.setImage(UIImage(systemName: "circle"), for: .normal)
            buton12Dolu=false}
    }
    @IBAction func buton62Clicked(_ sender: Any) {
        if(buton12Dolu==false){
            buton61.setImage(UIImage(systemName: "circle"), for: .normal)
            buton62.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton12Dolu=true}
        else if(buton12Dolu==true){
            buton61.setImage(UIImage(systemName: "circle"), for: .normal)
            buton62.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            buton12Dolu=true}
    }
    
    @IBAction func resimButtonClicked(_ sender: Any) {
    }
}
