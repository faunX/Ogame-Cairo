import pytest
from utils.helpers import (
    assert_equals, update_starknet_block, reset_starknet_block, get_block_timestamp,
    TIME_ELAPS_SIX_HOURS, TIME_ELAPS_ONE_HOUR)
from conftest import user1


@pytest.mark.asyncio
async def test_lab_upgrades(starknet, deploy_game_v1):
    (_, ogame, _, _, _, _, user_one, _, _) = deploy_game_v1

    await user1.send_transaction(user_one,
                                 ogame.contract_address,
                                 'GOD_MODE',
                                 [20, 8, 0, 0, 0, 8, 4, 0, 3, 5, 5, 10, 0, 5, 1])
    update_starknet_block(
        starknet=starknet, block_timestamp=TIME_ELAPS_ONE_HOUR*1000)

    await user1.send_transaction(user_one,
                                        ogame.contract_address,
                                        'shipyard_upgrade_start',
                                        [])
    update_starknet_block(
        starknet=starknet, block_timestamp=TIME_ELAPS_ONE_HOUR*1001)
    await user1.send_transaction(user_one,
                                        ogame.contract_address,
                                        'shipyard_upgrade_complete',
                                        [])

    data = await user1.send_transaction(user_one,
                                        ogame.contract_address,
                                        'get_structures_levels',
                                        [user_one.contract_address])
    assert_equals(data.result.response, [25, 23, 21, 30, 20, 20, 1])
