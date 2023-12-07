import { Identity } from "@semaphore-protocol/identity"
import { Group } from "@semaphore-protocol/group"
import { generateProof } from "@semaphore-protocol/proof"
import fs from 'fs';
import readlineSync from "readline-sync";

async function main() {
    try {
        const phrase = readlineSync.question("What is your secret value? Pls input in lower case: ");
        const identity: Identity = new Identity(phrase);
    
        const identityFile = fs.readFileSync('./json/identity.json', 'utf-8');
        const identityData = JSON.parse(identityFile);
        const group = new Group(42, 16, identityData);
        const externalNullifier = group.root;
    
        const signal = readlineSync.question("Pls select your opinion in decimal! [1/0]: ");
        if (signal != "0" && signal != "1") {
            console.log("Wrong Input!");
            return;
        }
    
        const fullProof = await generateProof(identity, group, externalNullifier, signal, {
            zkeyFilePath: "./semaphore/semaphore.zkey",
            wasmFilePath: "./semaphore/semaphore.wasm"
        });
        const input = {
            "vote": fullProof.signal,
            "nullifierHash": fullProof.nullifierHash,
            "pollId": 42,
            "proof": fullProof.proof
        }
        fs.writeFileSync('./json/input.json', JSON.stringify(input, null, 2));
    } catch (error) {
        console.log(error);
    }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
