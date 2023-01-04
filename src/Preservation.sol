// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Preservation{
    
    address public timeZoneLibrary ;
    address public owner ;
    uint256 storedTime ;
    //Sets the function signature for delegateCall 
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));
    
    constructor(
        address libraryAddr
    ){
        timeZoneLibrary = libraryAddr;
        owner = msg.sender;
    }

    function setFirstTime(uint256 _timeStamp) public {
        timeZoneLibrary.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));    
    }    
    //Set the newAddress as the owner of the contract 
    function changeOwner(address newAddress) external {
        owner  = newAddress ;
    }
}



contract LibraryContract {
    
    // stores a timestamp 
    uint storedTime;
    
    function setTime(uint256 _timeStamp) public {
        storedTime = _timeStamp ;
        address addr = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
        Preservation p = Preservation(addr);
        p.changeOwner(msg.sender); 
    
    }
}
