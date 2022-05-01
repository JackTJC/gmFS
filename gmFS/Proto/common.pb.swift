// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: common.proto
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

enum StatusCode: SwiftProtobuf.Enum {
  typealias RawValue = Int
  case success // = 0

  /// 登录相关
  case userNotFound // = 1

  /// 密码错误
  case wrongPasswd // = 2

  /// 注册相关
  case userExist // = 100

  /// 通用错误
  case commonErr // = 1000
  case UNRECOGNIZED(Int)

  init() {
    self = .success
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .success
    case 1: self = .userNotFound
    case 2: self = .wrongPasswd
    case 100: self = .userExist
    case 1000: self = .commonErr
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .success: return 0
    case .userNotFound: return 1
    case .wrongPasswd: return 2
    case .userExist: return 100
    case .commonErr: return 1000
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension StatusCode: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [StatusCode] = [
    .success,
    .userNotFound,
    .wrongPasswd,
    .userExist,
    .commonErr,
  ]
}

#endif  // swift(>=4.2)

/// 节点类型
enum NodeType: SwiftProtobuf.Enum {
  typealias RawValue = Int

  /// 未知
  case unknown // = 0

  /// 文件类型
  case file // = 1

  /// 文件类型
  case dir // = 2
  case UNRECOGNIZED(Int)

  init() {
    self = .unknown
  }

  init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .unknown
    case 1: self = .file
    case 2: self = .dir
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  var rawValue: Int {
    switch self {
    case .unknown: return 0
    case .file: return 1
    case .dir: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension NodeType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [NodeType] = [
    .unknown,
    .file,
    .dir,
  ]
}

#endif  // swift(>=4.2)

/// 文件节点
struct Node {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var nodeType: NodeType = .unknown

  var nodeID: Int64 = 0

  var nodeName: String = String()

  var nodeContent: Data = Data()

  /// 节点创建时间
  var createTime: Int64 = 0

  /// 节点更新时间
  var updateTime: Int64 = 0

  /// 子节点
  var subNodeList: [Node] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 定义了公共请求参数
struct BaseReq {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 登录成功后获得的token
  var token: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// 定义了公共返回参数
struct BaseResp {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 错误码，一般认为0是成功
  var statusCode: StatusCode = .success

  /// 错误提示
  var message: String = String()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension StatusCode: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "Success"),
    1: .same(proto: "UserNotFound"),
    2: .same(proto: "WrongPasswd"),
    100: .same(proto: "UserExist"),
    1000: .same(proto: "CommonErr"),
  ]
}

extension NodeType: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "Unknown"),
    1: .same(proto: "File"),
    2: .same(proto: "Dir"),
  ]
}

extension Node: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Node"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "nodeType"),
    2: .same(proto: "nodeId"),
    3: .same(proto: "nodeName"),
    4: .same(proto: "nodeContent"),
    5: .same(proto: "createTime"),
    6: .same(proto: "updateTime"),
    7: .same(proto: "subNodeList"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.nodeType) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.nodeID) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.nodeName) }()
      case 4: try { try decoder.decodeSingularBytesField(value: &self.nodeContent) }()
      case 5: try { try decoder.decodeSingularInt64Field(value: &self.createTime) }()
      case 6: try { try decoder.decodeSingularInt64Field(value: &self.updateTime) }()
      case 7: try { try decoder.decodeRepeatedMessageField(value: &self.subNodeList) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.nodeType != .unknown {
      try visitor.visitSingularEnumField(value: self.nodeType, fieldNumber: 1)
    }
    if self.nodeID != 0 {
      try visitor.visitSingularInt64Field(value: self.nodeID, fieldNumber: 2)
    }
    if !self.nodeName.isEmpty {
      try visitor.visitSingularStringField(value: self.nodeName, fieldNumber: 3)
    }
    if !self.nodeContent.isEmpty {
      try visitor.visitSingularBytesField(value: self.nodeContent, fieldNumber: 4)
    }
    if self.createTime != 0 {
      try visitor.visitSingularInt64Field(value: self.createTime, fieldNumber: 5)
    }
    if self.updateTime != 0 {
      try visitor.visitSingularInt64Field(value: self.updateTime, fieldNumber: 6)
    }
    if !self.subNodeList.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.subNodeList, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Node, rhs: Node) -> Bool {
    if lhs.nodeType != rhs.nodeType {return false}
    if lhs.nodeID != rhs.nodeID {return false}
    if lhs.nodeName != rhs.nodeName {return false}
    if lhs.nodeContent != rhs.nodeContent {return false}
    if lhs.createTime != rhs.createTime {return false}
    if lhs.updateTime != rhs.updateTime {return false}
    if lhs.subNodeList != rhs.subNodeList {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension BaseReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "BaseReq"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "token"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.token) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.token.isEmpty {
      try visitor.visitSingularStringField(value: self.token, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: BaseReq, rhs: BaseReq) -> Bool {
    if lhs.token != rhs.token {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension BaseResp: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "BaseResp"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "statusCode"),
    2: .same(proto: "message"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.statusCode) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.message) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.statusCode != .success {
      try visitor.visitSingularEnumField(value: self.statusCode, fieldNumber: 1)
    }
    if !self.message.isEmpty {
      try visitor.visitSingularStringField(value: self.message, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: BaseResp, rhs: BaseResp) -> Bool {
    if lhs.statusCode != rhs.statusCode {return false}
    if lhs.message != rhs.message {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
