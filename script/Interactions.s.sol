// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";
import {DeployMoodNft} from "./DeployMoodNft.s.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {console} from "forge-std/console.sol";

contract MintBasicNft is Script {
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function run() external {
        address mostrecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(mostrecentlyDeployed);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    DeployMoodNft deployer;
    MoodNft moodNft;

    function run() public {
        address mostrecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        mintMoodNftOnContract(mostrecentlyDeployed);
        
        /*deployer = new DeployMoodNft();
        moodNft = deployer.run();
        vm.startBroadcast();
        moodNft.mintNft();
        moodNft.tokenURI(0);
        vm.stopBroadcast();*/
        
       
    }

    function mintMoodNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        moodNft = MoodNft(contractAddress);
        moodNft.mintNft();
        moodNft.tokenURI(0);
        vm.stopBroadcast();
        
        
    }
}



contract FlipMoodNft is Script {
    function run() external {
        address mostrecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        flipMoodNftOnContract(mostrecentlyDeployed);
    }

    function flipMoodNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).flipMood(1);
        vm.stopBroadcast();
    }
}


contract ShowMoodNft is Script {
    function run() external view {
        address mostrecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "MoodNft",
            block.chainid
        );
        showMoodNftOnContract(mostrecentlyDeployed);
    }


    function showMoodNftOnContract(address contractAddress) public view {
        console.log(MoodNft(contractAddress).tokenURI(0));
        console.log(MoodNft(contractAddress).tokenURI(1));

    }
}
