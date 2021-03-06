pragma solidity ^0.5.0;

import "./Vault.sol";
import "./predicates/IEthDepositVerifier.sol";

contract EthVault is Vault {
    IEthDepositVerifier private _depositVerifier;

    constructor(address _blockController) Vault(_blockController) public {}

    /**
     * @notice Set the deposit verifier contract. This can be only called by the operator.
     * @param _contract address of the verifier contract.
     */
    function setDepositVerifier(address _contract) public onlyOperator {
        _depositVerifier = IEthDepositVerifier(_contract);
    }

    /**
     * @notice Allows a user to submit a deposit.
     * @param _depositTx RLP encoded transaction to act as the deposit.
     */
    function deposit(bytes calldata _depositTx) external payable {
        _depositVerifier.verify(_depositTx, msg.value, msg.sender);

        super._submitDepositBlock(_depositTx);
    }

    /**
    * @notice Withdraw plasma chain eth via transferring ETH.
    * @param _target Place to transfer eth.
    * @param _amount Amount of eth to transfer.
    */
    function withdraw(address payable _target, uint256 _amount) external onlyFromExitGame {
        _target.transfer(_amount);
    }
}
