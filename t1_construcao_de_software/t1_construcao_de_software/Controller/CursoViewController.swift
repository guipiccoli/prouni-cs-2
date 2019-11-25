//
//  ViewController.swift
//  t1_construcao_de_software
//
//  Created by Fernando Locatelli Maioli on 30/09/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//

import UIKit

class CursoViewController: UIViewController {
    
    var loading: UIActivityIndicatorView?
    
    @IBOutlet weak var cursoTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loading?.backgroundColor = .lightGray
        loading?.color = .black
        self.view.addSubview(loading!)
        
        
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRect = keyboardFrame.cgRectValue
        scrollView.contentInset.bottom = view.convert(CGRect(x: keyboardRect.minX, y: keyboardRect.minY, width: keyboardRect.maxX-keyboardRect.minX, height: (keyboardRect.maxY-keyboardRect.minY)+25), from: nil).size.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
    
    @IBAction func navegarButton(_ sender: UIButton) {
        guard let cursoNome = cursoTextField.text else { return }
        if !cursoNome.isEmpty {
            loading!.startAnimating()
            view?.bringSubviewToFront(loading!)
            
            DataAccess.getListaDeCursos(nota: 1000, uf_busca: "RS", cidade_busca: "Porto Alegre", universidade_nome: "PUCRS", nome: cursoNome, somente_cota: "", somente_integral: "") { (listaCursos) in
            
                DispatchQueue.main.async {
                    self.loading?.stopAnimating()
                    self.performSegue(withIdentifier: "Lista", sender: listaCursos)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? ListViewController
        let lista = sender as? [Curso]
        viewController?.listaCursos = lista
    }
    
    
    @IBAction func favoritosListButton(_ sender: Any) {
        
        loading!.startAnimating()
        view?.bringSubviewToFront(loading!)
        
        DataAccess.getListarFavoritos { (listaCursos) in
            DispatchQueue.main.async {
                self.loading?.stopAnimating()
                self.performSegue(withIdentifier: "Lista", sender: listaCursos)
            }
        }
        
    }
    

    
}

//MARK: - Hide Keyboard
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

