// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;


interface ASCToken {
    function transfer(address dst, uint wad) external returns (bool);
}

contract ASCAirdrop {
    uint a_val;
    ASCToken ascToken;
    mapping(address => bool) public recv_ad;
    address owner;   

    constructor() {        
        //dev only
        ascToken=ASCToken(0x19801617211f09a2Ef9C5E34eA8B2d7aAd8E79e2);

        //prod
        //ascToken=ASCToken(0x167DFB2f0ef926122ec0de9726602c504c46dF64);
        a_val=1;
        owner = msg.sender;
    }

    function receive_airdrop() public {    
        require(!recv_ad[msg.sender], "ya tuviste tu airdrop");
        ascToken.transfer(msg.sender,a_val);   
        recv_ad[msg.sender] = true;     
    }
    
    function update_airdrop_amount(uint value) public {
        a_val=value;
    }
    function unstake_tokens(uint _amount) public {
       require(msg.sender == owner, "owner only juira!");
       ascToken.transfer(msg.sender, _amount);
    }
    
}