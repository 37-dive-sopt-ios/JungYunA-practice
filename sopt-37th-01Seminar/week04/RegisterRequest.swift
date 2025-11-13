//
//  RegisterRequest.swift
//  sopt-37th-01Seminar
//
//  Created by 정윤아 on 11/8/25.
//
import Foundation

/// 유저 등록 API
struct RegisterRequest: Encodable {   //인코딩하는 애다 라고 알려줌 아님 걍 Codable 쓰기
    let username: String
        let password: String
        let name: String
        let email: String
        let age: Int
}
