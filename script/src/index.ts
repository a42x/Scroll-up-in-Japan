import { Identity } from "@semaphore-protocol/identity"
import { Group } from "@semaphore-protocol/group"
import { generateProof, verifyProof } from "@semaphore-protocol/proof"
import fs from 'fs';
import readlineSync from "readline-sync";

async function main() {
    try {
        const POLL_ID = 42;
        const phrase = readlineSync.question("What is your secret value?: ");
        const identity: Identity = new Identity(phrase);
    
        const identityFile = fs.readFileSync('./json/identity.json', 'utf-8');
        const identityData = JSON.parse(identityFile);
        const group = new Group(POLL_ID, 16, identityData);
        const externalNullifier = POLL_ID;
    
        const signal = readlineSync.question("Pls select your opinion in decimal! [1/0]: ");
        if (signal != "0" && signal != "1") {
            console.log("Wrong Input!");
            return;
        }
    
        const fullProof = await generateProof(identity, group, externalNullifier, signal, {
            zkeyFilePath: "./semaphore/semaphore.zkey",
            wasmFilePath: "./semaphore/semaphore.wasm"
        });
        const result = await verifyProof(fullProof, 16);
        console.log("Successfully generated?: ", result);
        const input = {
            "vote": fullProof.signal,
            "nullifierHash": fullProof.nullifierHash,
            "pollId": POLL_ID,
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
