const hre = require("hardhat");

async function main() {
    const VotingSystem = await hre.ethers.getContractFactory("VotingSystem");

    // Example candidates
    const candidates = ["Alice", "Bob", "Charlie"];

    const votingSystem = await VotingSystem.deploy(candidates);

    await votingSystem.deployed();

    console.log(`VotingSystem deployed to: ${votingSystem.address}`);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
