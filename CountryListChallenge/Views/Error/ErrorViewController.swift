import UIKit

class ErrorViewController: UIViewController {
    var retryAction: (() -> Void)?

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ErrorView.errorFetch.rawValue
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(ErrorView.retry.rawValue, for: .normal)
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private var progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        setupViews()
    }

    private func setupViews() {
        view.addSubview(errorLabel)
        view.addSubview(retryButton)

        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            retryButton.widthAnchor.constraint(equalToConstant: 100),
            retryButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    @objc private func retryButtonTapped() {
        retryButton.isEnabled = false
        retryButton.tintColor = .darkGray
        animateProgress()
        retryAction?()

        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) { [weak self] in
            self?.retryButton.isEnabled = true
            self?.progressView.removeFromSuperview()
        }
    }

    private func animateProgress() {
        view.addSubview(progressView)

        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: retryButton.leadingAnchor),
            progressView.topAnchor.constraint(equalTo: retryButton.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: retryButton.bottomAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 0)
        ])

        UIView.animate(withDuration: 10.0, delay: 0.0, options: .curveLinear, animations: { [weak self] in
            self?.progressView.widthAnchor.constraint(equalTo: self!.retryButton.widthAnchor, multiplier: 1.0).isActive = true
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
}




