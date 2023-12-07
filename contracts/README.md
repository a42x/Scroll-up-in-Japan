## デプロイの順番

### Build
```shell
$ forge build
```

### Deploy SemaphoreVerifier
```shell
$ forge script script/Deploy.s.sol:DeployVerifier --legacy --broadcast --rpc-url ${SCROLL_SEPOLIA_RPC_URL}
```

### Deploy SemaphoreVoting
```shell
$ forge script script/Deploy.s.sol:DeployVoting --legacy --broadcast --rpc-url ${SCROLL_SEPOLIA_RPC_URL}
```

### Verify Pairing
```shell
$ forge verify-contract ${PAIRING_ADDRESS} src/base/Pairing.sol:Pairing --verifier-url https://api-sepolia.scrollscan.com/api --etherscan-api-key  ${SCROLL_SCAN_API_KEY} --watch
```

### Verify SemaphoreVerifier
```shell
$ forge verify-contract ${SEMAPHORE_VERIFIER_ADDRESS} src/base/SemaphoreVerifier.sol:SemaphoreVerifier --verifier-url https://api-sepolia.scrollscan.com/api --etherscan-api-key  ${SCROLL_SCAN_API_KEY} --watch --libraries src/base/Pairing.sol:Pairing:${PAIRING_ADDRESS}
```

### Verify PoseidonT3
```shell
$ forge verify-contract ${POSEIDON_T3_ADDRESS} src/utils/PoseidonT3.sol:PoseidonT3 --verifier-url https://api-sepolia.scrollscan.com/api --etherscan-api-key  ${SCROLL_SCAN_API_KEY} --watch
```

### Verify IncrementalBinaryTree
```shell
$ forge verify-contract ${INCREMENTAL_BINARY_TREE_ADDRESS} src/utils/IncrementalBinaryTree.sol:IncrementalBinaryTree --verifier-url https://api-sepolia.scrollscan.com/api --etherscan-api-key  ${SCROLL_SCAN_API_KEY} --watch --libraries src/utils/PoseidonT3.sol:PoseidonT3:${POSEIDON_T3_ADDRESS}
```

### Verify SemaphoreVoting
```shell
$ forge verify-contract ${SEMAPHORE_VOTING_ADDRESS} src/extensions/SemaphoreVoting.sol:SemaphoreVoting --verifier-url https://api-sepolia.scrollscan.com/api --etherscan-api-key  ${SCROLL_SCAN_API_KEY} --watch --libraries src/utils/IncrementalBinaryTree.sol:IncrementalBinaryTree:${INCREMENTAL_BINARY_TREE_ADDRESS} --constructor-args $(cast abi-encode "constructor(address)" ${SEMAPHORE_VERIFIER_ADDRESS})
```

## それぞれのコントラクトの簡単な説明

### Pairing.sol


### SemaphoreGroups.sol


### SemaphoreVerifier.sol


### SemaphoreVoting.sol


### IncrementalBinaryTree.sol


### PoseidonT3.sol

