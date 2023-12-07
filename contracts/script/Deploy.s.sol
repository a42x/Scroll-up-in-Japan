// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.4;

import {Script, console2} from "forge-std/Script.sol";
import "../src/base/SemaphoreVerifier.sol";
import "../src/extensions/SemaphoreVoting.sol";

// Pairing => Verifier
// Pairing path: src/base/Pairing.sol
// pairing: 0x63064634877052ECC51620aC410f0a621284fbbf
// SemaphoreVerifier path: src/base/SemaphoreVerifier.sol
// SemaphoreVerifier: 0xf053cf588f2C5C1AB12770eD3f44858A08A2f130
// Poseidon path: lib/poseidon-solidity/contracts/PoseidonT3.sol
// Poseidon: 0x5BCBe232fD0feDAc6f8417840d13d7e2235DdcE8
// BinaryIMT path: lib/zk-kit/packages/incremental-merkle-tree.sol/contracts/IncrementalBinaryTree.sol
// BinaryIMT: 0xC9e989B66760D3a7420f40ECB1553B60bCB9eEFf
// SemaphoreVoting path: src/extensions/SemaphoreVoting.sol
// SemaphoreVoting: 0xf565f5ca65f1b4A295991f247f17de6252C47681
// poseidon => IMT => Voting

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
