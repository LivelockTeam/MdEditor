//
//  LoginModel.swift
//  TodoList
//
//  Created by Kirill Leonov on 24.11.2023.
//

import Foundation

/// LoginModel является NameSpace VIP цикла сцены Login
enum LoginModel {

	/// Структура запроса View к Interractor в сцене Login
	struct Request {
		var login: String
		var password: String
	}

	/// Структура ответа Interractor для Presenter в сцене Login
	struct Response {
		var result: Result<Void, LoginError>
	}
}
