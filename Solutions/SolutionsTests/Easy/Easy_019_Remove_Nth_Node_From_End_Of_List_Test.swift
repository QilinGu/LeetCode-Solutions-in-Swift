//
//  Easy_019_Remove_Nth_Node_From_End_Of_List_Test.swift
//  Solutions
//
//  Created by Di Wu on 4/20/15.
//  Copyright (c) 2015 diwu. All rights reserved.
//

import XCTest

class Easy_019_Remove_Nth_Node_From_End_Of_List_Test: XCTestCase {

    private static let ProblemName: String = "Easy_019_Remove_Nth_Node_From_End_Of_List"
    private static let TimeOutName = ProblemName + Default_Timeout_Suffix
    private static let TimeOut = Default_Timeout_Value

    private typealias Node = Easy_019_Remove_Nth_Node_From_End_Of_List.Node

    func test_001() {
        let input: [AnyObject] = [[1, 2, 3, 4, 5], 2]
        let expected: [Int] = [1, 2, 3, 5]
        asyncHelper(input: input, expected: expected)
    }

    func test_002() {
        let input: [AnyObject] = [[], 2]
        let expected: [Int] = []
        asyncHelper(input: input, expected: expected)
    }

    func test_003() {
        let input: [AnyObject] = [[1, 2], 2]
        let expected: [Int] = [2]
        asyncHelper(input: input, expected: expected)
    }

    func test_004() {
        let input: [AnyObject] = [[1, 2, 3], 3]
        let expected: [Int] = [2, 3]
        asyncHelper(input: input, expected: expected)
    }

    func test_005() {
        let input: [AnyObject] = [[1], 1]
        let expected: [Int] = []
        asyncHelper(input: input, expected: expected)
    }

    private func helper1(_ intArray: [Int]) -> Node? {
        var nodeArray: [Node] = []
        for i in intArray {
            let node: Node = Node(value: i, next: nil)
            nodeArray.append(node)
        }
        if nodeArray.count == 0 {
            return nil
        }
        for i in 0..<nodeArray.count-1 {
            nodeArray[i].next = nodeArray[i+1]
        }
        return nodeArray[0]
    }

    private func helper2(_ head: Node?) -> [Int] {
        var res: [Int] = []
        var localHead = head
        while localHead != nil {
            res.append(localHead!.value)
            localHead = localHead?.next
        }
        return res
    }

    func asyncHelper(input: [AnyObject], expected: [Int]) {
        weak var expectation: XCTestExpectation? = self.expectation(withDescription: Easy_019_Remove_Nth_Node_From_End_Of_List_Test.TimeOutName)
        DispatchQueue.global(attributes: DispatchQueue.GlobalAttributes.qosDefault).async(execute: { () -> Void in
            let result: [Int] = self.helper2(Easy_019_Remove_Nth_Node_From_End_Of_List.removeNthFromEnd(self.helper1(input[0] as! [Int]), n: input[1] as! Int))
            assertHelper(expected == result, problemName: Easy_019_Remove_Nth_Node_From_End_Of_List_Test.ProblemName, input: input, resultValue: result, expectedValue: expected)
            if let unwrapped = expectation {
                unwrapped.fulfill()
            }
        })
        waitForExpectations(withTimeout: Easy_019_Remove_Nth_Node_From_End_Of_List_Test.TimeOut) { (error: NSError?) -> Void in
            if error != nil {
                assertHelper(false, problemName: Easy_019_Remove_Nth_Node_From_End_Of_List_Test.ProblemName, input: input, resultValue: Easy_019_Remove_Nth_Node_From_End_Of_List_Test.TimeOutName, expectedValue: expected)
            }
        }
    }
}
