//
//  FiltrosViewController.swift
//  t1_construcao_de_software
//
// Classe que realiza o filtro de todos os cursos disponiveis que apareceram na lista
//
//  Created by Fernando Locatelli Maioli on 30/09/19.
//  Copyright © 2019 Fernando Locatelli Maioli. All rights reserved.
//

import UIKit

class FiltrosViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var cursoTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    var loading: UIActivityIndicatorView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        loading?.backgroundColor = .lightGray
        loading?.color = .black
        self.view.addSubview(loading!)
    
        
        self.hideKeyboardWhenTappedAround()
        scrollView.isScrollEnabled = true
        
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as? AdministradorViewController
        let lista = sender as? [Curso]
        viewController?.listaTodosCursos = lista
    }
    
    @IBAction func filterButtonAction(_ sender: UIButton) {
        loading!.startAnimating()
        view?.bringSubviewToFront(loading!)
        
        DataAccess.getListaDeCursos(nota: 1000, uf_busca: "RS", cidade_busca: "Porto Alegre", universidade_nome: "PUCRS", nome: cursoTextField.text ?? "", somente_cota: "", somente_integral: "") { (listaCursos) in
        
            DispatchQueue.main.async {
                self.loading?.stopAnimating()
                self.performSegue(withIdentifier: "ListaAdm", sender: listaCursos)
            }
        }
    }
}
