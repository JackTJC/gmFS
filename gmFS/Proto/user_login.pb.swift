// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: user_login.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct UserLoginRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 用户名
  var userName: String = String()

  /// 密码
  var password: String = String()

  var baseReq: BaseReq {
    get {return _baseReq ?? BaseReq()}
    set {_baseReq = newValue}
  }
  /// Returns true if `baseReq` has been explicitly set.
  var hasBaseReq: Bool {return self._baseReq != nil}
  /// Clears the value of `baseReq`. Subsequent reads from it will return its default value.
  mutating func clearBaseReq() {self._baseReq = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _baseReq: BaseReq? = nil
}

struct UserInfo {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var rootID: Int64 = 0

  var userName: String = String()

  var email: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct UserLoginResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///  登录成功返回的token
  var token: String = String()

  /// 用户信息
  var userInfo: UserInfo {
    get {return _userInfo ?? UserInfo()}
    set {_userInfo = newValue}
  }
  /// Returns true if `userInfo` has been explicitly set.
  var hasUserInfo: Bool {return self._userInfo != nil}
  /// Clears the value of `userInfo`. Subsequent reads from it will return its default value.
  mutating func clearUserInfo() {self._userInfo = nil}

  var baseResp: BaseResp {
    get {return _baseResp ?? BaseResp()}
    set {_baseResp = newValue}
  }
  /// Returns true if `baseResp` has been explicitly set.
  var hasBaseResp: Bool {return self._baseResp != nil}
  /// Clears the value of `baseResp`. Subsequent reads from it will return its default value.
  mutating func clearBaseResp() {self._baseResp = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _userInfo: UserInfo? = nil
  fileprivate var _baseResp: BaseResp? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension UserLoginRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "UserLoginRequest"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "userName"),
    2: .same(proto: "password"),
    255: .same(proto: "baseReq"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.userName) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.password) }()
      case 255: try { try decoder.decodeSingularMessageField(value: &self._baseReq) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.userName.isEmpty {
      try visitor.visitSingularStringField(value: self.userName, fieldNumber: 1)
    }
    if !self.password.isEmpty {
      try visitor.visitSingularStringField(value: self.password, fieldNumber: 2)
    }
    try { if let v = self._baseReq {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 255)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UserLoginRequest, rhs: UserLoginRequest) -> Bool {
    if lhs.userName != rhs.userName {return false}
    if lhs.password != rhs.password {return false}
    if lhs._baseReq != rhs._baseReq {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension UserInfo: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "UserInfo"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "rootId"),
    2: .same(proto: "userName"),
    3: .same(proto: "email"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.rootID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.userName) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.email) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.rootID != 0 {
      try visitor.visitSingularInt64Field(value: self.rootID, fieldNumber: 1)
    }
    if !self.userName.isEmpty {
      try visitor.visitSingularStringField(value: self.userName, fieldNumber: 2)
    }
    if !self.email.isEmpty {
      try visitor.visitSingularStringField(value: self.email, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UserInfo, rhs: UserInfo) -> Bool {
    if lhs.rootID != rhs.rootID {return false}
    if lhs.userName != rhs.userName {return false}
    if lhs.email != rhs.email {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension UserLoginResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "UserLoginResponse"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "token"),
    2: .same(proto: "userInfo"),
    255: .same(proto: "baseResp"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.token) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._userInfo) }()
      case 255: try { try decoder.decodeSingularMessageField(value: &self._baseResp) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.token.isEmpty {
      try visitor.visitSingularStringField(value: self.token, fieldNumber: 1)
    }
    try { if let v = self._userInfo {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._baseResp {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 255)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: UserLoginResponse, rhs: UserLoginResponse) -> Bool {
    if lhs.token != rhs.token {return false}
    if lhs._userInfo != rhs._userInfo {return false}
    if lhs._baseResp != rhs._baseResp {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
