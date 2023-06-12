//
//  Serialization.swift
//  
//
//  Created by James Murphy on 6/8/23.
//

import Foundation

enum JsonSerializationError: Error {
    case DecodeError
    case EncodeError
}



func make_struct_from_string<T: Decodable>(_ json_string: String) -> Result<T, JsonSerializationError> {
    let jsonDecoder = JSONDecoder()
    let jsonData = json_string.data(using: .utf8)!
   
    do {
        let a_struct: T = try jsonDecoder.decode(T.self, from: jsonData)
        return .success(a_struct)
        
    } catch {
        return .failure(JsonSerializationError.DecodeError)
    }
}

func make_string_from_struct<T: Encodable>(a_struct: T) -> Result<String, JsonSerializationError> {
    
    let jsonEncoder = JSONEncoder()
    
    do {
        let jsonData = try jsonEncoder.encode(a_struct)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return .success(jsonString)
        
    } catch {
        return .failure(JsonSerializationError.EncodeError)
    }
}
// init(_ msg_type: MessageType, _ payload: String? = nil)
func make_message<T: IIDMessageType>(_ aMessageType: T, _ message: MessageType) -> IIDMessage {
    let jsonEncoder = JSONEncoder()
    do {
        let jsonData = try jsonEncoder.encode(aMessageType)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return IIDMessage(message, jsonString)
        
    } catch {
        return IIDMessage(MessageType.Invalid, nil)
    }
}
