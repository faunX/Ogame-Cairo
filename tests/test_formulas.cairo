%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.utils.Formulas import (
    formulas_solar_plant,
    _resources_production_formula,
    formulas_solar_plant_building,
    formulas_metal_building,
    formulas_crystal_building,
    formulas_deuterium_building,
    formulas_production_scaler,
)

@external
func test_resources_production{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }() -> ():
    # Test for metal production scaled to 10k
    let (actual) = _resources_production_formula(30, 2)
    let expected = 720000
    assert actual = expected
    let (actual) = _resources_production_formula(30, 10)
    let expected = 7780000
    assert actual = expected
    let (actual) = _resources_production_formula(30, 25)
    let expected = 81260000
    assert actual = expected
    # Test for crystal production scaled to 10k
    let (actual) = _resources_production_formula(20, 2)
    let expected = 480000
    assert actual = expected
    let (actual) = _resources_production_formula(20, 10)
    let expected = 5180000
    assert actual = expected
    let (actual) = _resources_production_formula(20, 25)
    let expected = 54170000
    assert actual = expected
    # Test for deuterium production scaled to 10k
    let (actual) = _resources_production_formula(10, 2)
    let expected = 240000
    assert actual = expected
    let (actual) = _resources_production_formula(10, 10)
    let expected = 2590000
    assert actual = expected
    let (actual) = _resources_production_formula(10, 25)
    let expected = 27080000
    assert actual = expected
    return()
end


@external
func test_solar_plant_production{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }() -> ():
    let (actual) = formulas_solar_plant(2)
    let expected = 48
    assert actual = expected

    let (actual) = formulas_solar_plant(10)
    let expected = 518
    assert actual = expected
    
    let (actual) = formulas_solar_plant(25)
    let expected = 5417
    assert actual = expected
    return()
end

@external
func test_metal_building_cost{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }() -> ():
    let (metal, crystal) = formulas_metal_building(1)
    let expected = (90, 22)
    assert (metal, crystal) = expected

    let (metal, crystal) = formulas_metal_building(9)
    let expected = (2306, 576) 
    assert (metal, crystal) = expected
    
    let (metal, crystal) = formulas_metal_building(24)
    let expected = (1010046, 252511)
    assert (metal, crystal) = expected
    return()
end

@external
func test_crystal_building_cost{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }() -> ():
    let (metal, crystal) = formulas_crystal_building(1)
    let expected = (76, 38)
    assert (metal, crystal) = expected

    let (metal, crystal) = formulas_crystal_building(9)
    let expected = (3298, 1649) 
    assert (metal, crystal) = expected
    
    let (metal, crystal) = formulas_crystal_building(24)
    let expected = (3802951, 1901475)
    assert (metal, crystal) = expected
    return()
end

@external
func test_deuterium_building_cost{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }() -> ():
    let (metal, crystal) = formulas_deuterium_building(1)
    let expected = (337, 112)
    assert (metal, crystal) = expected

    let (metal, crystal) = formulas_deuterium_building(9)
    let expected = (8649, 2883) 
    assert (metal, crystal) = expected
    
    let (metal, crystal) = formulas_deuterium_building(24)
    let expected = (3787675, 1262558)
    assert (metal, crystal) = expected
    return()
end

@external
func test_solar_plant_building_cost{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }():
    let (metal, crystal) = formulas_solar_plant_building(1)
    let expected = (75, 30)
    assert (metal, crystal) = expected

    let (metal, crystal) = formulas_solar_plant_building(9)
    let expected = (2883, 1153) 
    assert (metal, crystal) = expected
    
    let (metal, crystal) = formulas_solar_plant_building(24)
    let expected = (1262558, 505023)
    assert (metal, crystal) = expected
    return()
end

@external
func test_production_scaler{
        syscall_ptr : felt*,
        pedersen_ptr : HashBuiltin*, 
        range_check_ptr
        }():
    let (metal, crystal, deuterium) = formulas_production_scaler(1000, 500, 250, 100, 1250)
    let expected = (1000, 500, 250)
    assert (metal, crystal, deuterium) = expected

    let (metal, crystal, deuterium) = formulas_production_scaler(1000, 500, 250, 100, 33)
    let expected = (330, 165, 82)
    assert (metal, crystal, deuterium) = expected

    let (metal, crystal, deuterium) = formulas_production_scaler(1000, 1500, 250, 100, 50)
    let expected = (500, 250, 125)
    assert (metal, crystal, deuterium) = expected
    return()
end