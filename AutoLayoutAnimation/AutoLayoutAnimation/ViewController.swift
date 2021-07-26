//
//  ViewController.swift
//  Sueaty
//
//  Created by 서명렬 on 2021/07/26.
//

import UIKit


// MARK: - Animation using Deactivate / Activate

final class ViewController: UIViewController {

  private let firstView = UIView(frame: .zero)
  private let secondView = UIView(frame: .zero)
  private let thirdView = UIView(frame: .zero)
  private let button = UIButton(frame: .zero)

  private var isTapped = false

  private lazy var originConstraints = [
    secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
    thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
    thirdView.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 1),
  ]
  private lazy var updatedConstraints = [
    secondView.topAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: 10),
    thirdView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
    thirdView.widthAnchor.constraint(equalTo: firstView.widthAnchor, multiplier: 0.7),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupConstraints()
  }
}

private extension ViewController {

  func setupView() {
    firstView.backgroundColor = .blue
    secondView.backgroundColor = .black
    thirdView.backgroundColor = .red

    button.setTitle("Animate", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .gray
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
  }

  func setupConstraints() {
    [firstView, secondView, thirdView, button].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

    NSLayoutConstraint.activate(originConstraints)

    NSLayoutConstraint.activate([
      firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
      firstView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
      firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      firstView.heightAnchor.constraint(equalToConstant: 100),

      secondView.heightAnchor.constraint(equalToConstant: 100),
      secondView.widthAnchor.constraint(equalTo: firstView.widthAnchor),
      secondView.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),

      thirdView.heightAnchor.constraint(equalToConstant: 100),
      thirdView.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),


      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
      button.widthAnchor.constraint(equalToConstant: 100),
      button.heightAnchor.constraint(equalToConstant: 50),
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),

    ])
  }

  @objc func buttonTapped(_ sender: UIButton) {
    isTapped = !isTapped

    NSLayoutConstraint.deactivate(isTapped ? originConstraints : updatedConstraints)
    NSLayoutConstraint.activate(isTapped ? updatedConstraints : originConstraints)


    UIViewPropertyAnimator.runningPropertyAnimator(
      withDuration: 0.7,
      delay: 0,
      options: []
    ) { [weak self] in
      self?.view.layoutIfNeeded()
    }
  }
}


// MARK: - Animation using Constraint constant

//final class ViewController: UIViewController {
//
//  private let firstView = UIView(frame: .zero)
//  private let secondView = UIView(frame: .zero)
//  private let thirdView = UIView(frame: .zero)
//  private let button = UIButton(frame: .zero)
//
//  private var isTapped = false
//
//  private lazy var secondViewHeightConstraint = secondView.heightAnchor.constraint(equalToConstant: 100)
//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    setupView()
//    setupConstraints()
//  }
//}
//
//private extension ViewController {
//
//  func setupView() {
//    firstView.backgroundColor = .blue
//    secondView.backgroundColor = .black
//    thirdView.backgroundColor = .red
//
//    button.setTitle("Animate", for: .normal)
//    button.setTitleColor(.black, for: .normal)
//    button.backgroundColor = .gray
//    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//  }
//
//  func setupConstraints() {
//    [firstView, secondView, thirdView, button].forEach {
//      $0.translatesAutoresizingMaskIntoConstraints = false
//      view.addSubview($0)
//    }
//
//    NSLayoutConstraint.activate([
//      firstView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//      firstView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//      firstView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//      firstView.heightAnchor.constraint(equalToConstant: 100),
//
//      secondView.topAnchor.constraint(equalTo: firstView.bottomAnchor, constant: 10),
//      secondView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
//      secondView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
//      secondViewHeightConstraint,
//
//      thirdView.topAnchor.constraint(equalTo: secondView.bottomAnchor, constant: 10),
//      thirdView.heightAnchor.constraint(equalToConstant: 100),
//      thirdView.leadingAnchor.constraint(equalTo: firstView.leadingAnchor),
//      thirdView.trailingAnchor.constraint(equalTo: firstView.trailingAnchor),
//
//      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//      button.widthAnchor.constraint(equalToConstant: 100),
//      button.heightAnchor.constraint(equalToConstant: 50),
//      button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//
//    ])
//  }
//
//  @objc func buttonTapped(_ sender: UIButton) {
//    isTapped = !isTapped
//    secondViewHeightConstraint.constant = isTapped ? 0 : 100
//
//    UIViewPropertyAnimator.runningPropertyAnimator(
//      withDuration: 0.7,
//      delay: 0,
//      options: []
//    ) { [weak self] in
//      self?.view.layoutIfNeeded()
//    }
//  }
//}
