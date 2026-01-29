// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_InitialValue() public {
        assertEq(counter.x(), 0, unicode"初始值應為 0");
    }

    function test_IncOnce() public {
        counter.inc();
        assertEq(counter.x(), 1, unicode"x 應該增加到 1");
    }

    function testFuzz_Inc(uint8 x) public {
        for (uint8 i = 0; i < x; i++) {
            counter.inc();
        }
        assertEq(counter.x(), x, unicode"x 應該等於呼叫 inc 次數");
    }

    function test_IncByZero() public {
        vm.expectRevert();
        counter.incBy(0);
    }

    function test_IncByPositive() public {
        counter.incBy(5);
        assertEq(counter.x(), 5, unicode"x 應該增加到 5");
    }

    function test_IncByMaxUint() public {
        uint max = type(uint).max;
        counter.incBy(max);
        assertEq(counter.x(), max, unicode"x 應該等於 uint 最大值");
    }

   function test_EventEmitted() public {
    vm.expectEmit(true, true, false, true);
    emit Counter.Increment(1);
    counter.inc();
  }
}