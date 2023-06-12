import XCTest
@testable import fbp

final class fbpTests: XCTestCase {
    
    func testIIDMessage() throws {
        let msg_string = "foo"
        let msg = IIDMessage(MessageType.Data, msg_string)
        XCTAssertEqual(msg.msg_type, MessageType.Data)
        XCTAssertEqual(msg.payload, msg_string)
        XCTAssertEqual(msg.sub_msg_type, SubMessageType.Normal)
    }
    
    func test_config_message() throws {
        let config_data = "{\"log_file_path\":\"Log_file.txt\"}"
        let config_msg = ConfigMessage(ConfigMessageType.Field, config_data)
        
        let json_string_result = make_string_from_struct(a_struct: config_msg)
        
        var json_string: String = ""
        switch (json_string_result) {
        case .success(let jstring): json_string = jstring
        case .failure(let error): print(error); XCTAssert(false)
        }
        
        var a_config_msg = ConfigMessage(ConfigMessageType.Invalid, nil)
        let aResult:Result<ConfigMessage, JsonSerializationError>  = make_struct_from_string(json_string)
        switch (aResult) {
            case .success(let cmsg): a_config_msg = cmsg
            case .failure(let error): print(error); XCTAssert(false)
        }
        
        XCTAssertEqual(config_msg.data, a_config_msg.data)
        
    }

    func test_process_message() throws {
        let prop_msg = ProcessMessage(ProcessMessageType.Stop, true)
        XCTAssertEqual(prop_msg.msg_type, ProcessMessageType.Stop)
        XCTAssertTrue(prop_msg.propagate)
        
        let a_msg = make_message(prop_msg, MessageType.Process)
        XCTAssertEqual(a_msg.msg_type, MessageType.Process)
        XCTAssertNotNil(a_msg.payload)
        
        var a_process_msg = ProcessMessage(ProcessMessageType.Invalid, false)
        let aResult:Result<ProcessMessage, JsonSerializationError>  = make_struct_from_string(a_msg.payload!)
        
        switch (aResult) {
            case .success(let pmsg): a_process_msg = pmsg
            case .failure(let error): print(error); XCTAssert(false)
        }
        
        XCTAssertEqual(a_process_msg.msg_type, ProcessMessageType.Stop)
        XCTAssertTrue(a_process_msg.propagate)
        
    }
}
