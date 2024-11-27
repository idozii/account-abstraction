-include .env

deploy:;
	forge script script/DeployAccountAbstraction.s.sol:DeployAccountAbstraction --rpc-url ${ANVIL_RPC_URL} --broadcast --account idozii4-anvil

estimateAndSetGasFee:;
	forge script script/Interactions.s.sol:EstimateAndSetGasFee --rpc-url ${ANVIL_RPC_URL} --broadcast --account idozii4-anvil

setPaymasterAndDataAndSign:;
	forge script script/Interactions.s.sol:SetPaymasterAndDataAndSign --rpc-url ${ANVIL_RPC_URL} --broadcast --account idozii4-anvil

