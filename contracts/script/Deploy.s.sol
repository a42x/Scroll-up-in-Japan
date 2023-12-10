// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import {Script, console2} from "forge-std/Script.sol";
import "../src/base/SemaphoreVerifier.sol";
import "../src/extensions/SemaphoreVoting.sol";

contract DeployVerifier is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        // vm.startBroadcast();
        SemaphoreVerifier verifier = new SemaphoreVerifier();
        console2.log("Deployed verifier at: ", address(verifier));
        vm.stopBroadcast();
    }
}

contract DeployVoting is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address verifierAddress = vm.envAddress("SEMAPHORE_VERIFIER_ADDRESS");
        SemaphoreVoting voting = new SemaphoreVoting(
            ISemaphoreVerifier(verifierAddress)
        );
        console2.log("Deployed verifier at: ", address(voting));
        vm.stopBroadcast();
    }
}
