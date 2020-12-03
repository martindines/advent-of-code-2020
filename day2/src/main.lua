local stringmatch, stringbyte, stringsub = string.match, string.byte, string.sub

function main()
    local filename = arg[1]

    if filename == nil or filename == '' then
        error('Input filepath required')
    end

    local file = assert(io.open(filename, "r"))
    local input = file:read("*all")
    file:close()

    part1(input)
    part2(input)
end

function part1(input)
    local total_passwords = 0

    local lines = {}
    for line in string.gmatch(input, "[^\n]+") do
        lines[#lines+1] = line
        total_passwords = total_passwords + 1
    end

    local invalid_passwords = total_passwords

    for _, line in pairs(lines) do
        local policy_lower, policy_higher, policy_character, password = stringmatch(line, "^(%d+)-(%d+) (%w): (.*)$")
        policy_lower = tonumber(policy_lower)
        policy_higher = tonumber(policy_higher)

        --Create an empty array to store the character counts
        local password_character_count = {}

        --Record the number of occurrences of each character in the password
        local password_characters = {stringbyte(password, 1, #password)}
        for i = 1, #password_characters do
            if password_character_count[password_characters[i]] == nil then
                password_character_count[password_characters[i]] = 1
            else
                password_character_count[password_characters[i]] = password_character_count[password_characters[i]] + 1;
            end
        end

        --Password Validation
        --A password is considered valid if the policy character appears within the password between policy_lower and
        --policy_higher times
        local policy_character_count = password_character_count[stringbyte(policy_character)]
        if policy_character_count ~= nil then
            if policy_character_count >= policy_lower and policy_character_count <= policy_higher then
                invalid_passwords = invalid_passwords - 1
            end
        end
    end

    print('Part 1:')
    print('Total passwords', total_passwords)
    print('Valid passwords', total_passwords - invalid_passwords)
end

function part2(input)
    local total_passwords = 0

    local lines = {}
    for line in string.gmatch(input, "[^\n]+") do
        lines[#lines+1] = line
        total_passwords = total_passwords + 1
    end

    local invalid_passwords = total_passwords

    for _, line in pairs(lines) do
        local policy_first, policy_second, policy_character, password = stringmatch(line, "^(%d+)-(%d+) (%w): (.*)$")
        policy_first = tonumber(policy_first)
        policy_second = tonumber(policy_second)

        local matches = 0
        if stringsub(password, policy_first, policy_first) == policy_character then
            matches = matches + 1
        end

        if stringsub(password, policy_second, policy_second) == policy_character then
            matches = matches + 1
        end

        --Password Validation
        --A password is considered valid if the policy character is found once at either policy_first or policy_second
        --position
        if matches == 1 then
            invalid_passwords = invalid_passwords - 1
        end
    end

    print('Part 2:')
    print('Total passwords', total_passwords)
    print('Valid passwords', total_passwords - invalid_passwords)
end

main()