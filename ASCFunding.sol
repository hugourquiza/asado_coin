// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;


interface DAI {
    function transfer(address dst, uint wad) external returns (bool);
    function transferFrom(address src, address dst, uint wad) external returns (bool);
    function balanceOf(address guy) external view returns (uint);    
}


interface ASC {
    function transfer(address dst, uint wad) external returns (bool);
}


contract ASCFunding {
    DAI public dai_token;
    ASC public asc_token;
    address owner;    

    constructor(address asc_token_addr,address dai_token_addr) {        
        dai_token = DAI(dai_token_addr);
        asc_token=ASC(asc_token_addr);
        owner = msg.sender;
    }

    modifier owner_only() {
        require(msg.sender == owner, "owner only juira!");
        _;
    }

    function get_asc(uint _amount) public {
        require(_amount > 0, "amount should be > 0");        
        dai_token.transferFrom(msg.sender, address(this), _amount);                
        asc_token.transfer(msg.sender,_amount/1000000000000000000);
    }

    function get_dai() public owner_only {
       dai_token.transfer(msg.sender, dai_token.balanceOf(address(this)));
    }

    function remove_asc(uint _amount) public owner_only {       
       asc_token.transfer(msg.sender, _amount );
    }
    
}