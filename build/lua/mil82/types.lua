local types = {
    {
        name = '00.00',
        gas = 'CO2',
        scale = 4,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 5,
            [14] = 0.1,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '00.01',
        gas = 'CO2',
        scale = 10,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 5,
            [14] = 0.1,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '00.02',
        gas = 'CO2',
        scale = 20,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 5,
            [14] = 0.1,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '01.00',
        gas = 'CH4',
        scale = 100,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 7.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '01.01',
        gas = 'CH4',
        scale = 100,
        temp_low = -60,
        temp_high = 60,
        coefficient = {
            [4] = 7.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '02.00',
        gas = 'C3H8',
        scale = 50,
        temp_low = -40,
        temp_high = 60,
        coefficient = {
            [4] = 12.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 30,
            [50] = 0,
        },
    },
    {
        name = '02.01',
        gas = 'C3H8',
        scale = 50,
        temp_low = -60,
        temp_high = 60,
        coefficient = {
            [4] = 12.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 30,
            [50] = 0,
        },
    },
    {
        name = '03.00',
        gas = 'C3H8',
        scale = 100,
        temp_low = -40,
        temp_high = 60,
        coefficient = {
            [4] = 12.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 30,
            [50] = 0,
        },
    },
    {
        name = '03.01',
        gas = 'C3H8',
        scale = 100,
        temp_low = -60,
        temp_high = 60,
        coefficient = {
            [4] = 12.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 30,
            [50] = 0,
        },
    },
    {
        name = '04.00',
        gas = 'CH4',
        scale = 100,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 7.5,
            [14] = 0.5,
            [35] = 5,
            [45] = 60,
            [50] = 0,
        },
    },
    {
        name = '05.00',
        gas = 'C6H14',
        scale = 50,
        temp_low = 15,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 5,
            [45] = 30,
            [50] = 0,
        },
    },
    {
        name = '10.00',
        gas = 'CO2',
        scale = 4,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '10.01',
        gas = 'CO2',
        scale = 10,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '10.02',
        gas = 'CO2',
        scale = 20,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '10.03',
        gas = 'CO2',
        scale = 4,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '10.04',
        gas = 'CO2',
        scale = 10,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '10.05',
        gas = 'CO2',
        scale = 20,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '11.00',
        gas = 'CH4',
        scale = 100,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '11.01',
        gas = 'CH4',
        scale = 100,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '13.00',
        gas = 'C3H8',
        scale = 100,
        temp_low = -40,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
        index = 20
    },
    {
        name = '13.01',
        gas = 'C3H8',
        scale = 100,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '14.00',
        gas = 'CH4',
        scale = 100,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
    {
        name = '16.00',
        gas = 'C3H8',
        scale = 100,
        temp_low = -60,
        temp_high = 80,
        coefficient = {
            [4] = 1,
            [14] = 30,
            [35] = 1,
            [45] = 30,
            [50] = 1,
        },
    },
}

local ret = {}

for i, t in ipairs(types) do
    t.index = i
    ret[t.name] = t
end

return ret