pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

interface IErc20DepositVerifier {
    /**
     * @notice Verifies a deposit transaction.
     * @param _depositTx The deposit transaction.
     * @param _sender The owner of the deposit transaction.
     */
    function verify(bytes calldata _depositTx, address _sender, address _vault) external view returns (address owner, address token, uint256 amount);
}
