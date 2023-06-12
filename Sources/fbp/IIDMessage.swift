//
//  IIDMessage.swift
//  
//
//  Created by James Murphy on 6/7/23.
//

import Foundation

protocol IIDMessageType: Codable {}

public enum MessageType: IIDMessageType {
    case Data
    case Donfig
    case Process
    case Invalid
}

public enum SubMessageType: IIDMessageType {
    case Normal
    case Reply
    case Invalid
}

public enum ConfigMessageType: IIDMessageType {
    case Connect
    case Disconnect
    case Field
    case Invalid
}

public enum ProcessMessageType: IIDMessageType {
    case Stop
    case Suspend
    case Restart
    case Invalid
}

public struct IIDMessage: IIDMessageType {
    var msg_type = MessageType.Invalid
    var sub_msg_type = SubMessageType.Normal
    var payload: String?
    
    init(_ msg_type: MessageType, _ payload: String? = nil) {
        self.msg_type = msg_type
        self.payload = payload
    }
}

public struct FieldConfiguration: IIDMessageType {
    var field_name: String
    var config_string: String

    init(_ field_name: String, _ config_string: String) {
        self.field_name = field_name
        self.config_string = config_string
    }
}

public struct ConfigMessage: IIDMessageType {
    var msg_type: ConfigMessageType
    var data: String?

    init(_ msg_type: ConfigMessageType, _ data: String?) {
        self.msg_type = msg_type
        self.data = data
    }
}

public struct ProcessMessage: IIDMessageType {
    var msg_type: ProcessMessageType
    var propagate: Bool
    var message_node: String? = nil

    init(_ msg_type: ProcessMessageType, _ propagate: Bool) {
        self.msg_type = msg_type
        self.propagate = propagate
    }
}

enum JsonDecodingError: Error {
    case DecodeError
}




