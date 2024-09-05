local M = {}

---@param hex string: A string representing a hex color (e.g., '#ff0000')
---@return number, number, number: Red, green, and blue values (0-255)
local function hex_to_rgb(hex)
  hex = hex:gsub('#', '')
  local red = tonumber(hex:sub(1, 2), 16)
  local green = tonumber(hex:sub(3, 4), 16)
  local blue = tonumber(hex:sub(5, 6), 16)

  return red, green, blue
end

---@param r number: Red (0-255)
---@param g number: Green (0-255)
---@param b number: Blue (0-255)
---@return string: A string representing the hex color (e.g., '#ff0000')
local function rgb_to_hex(r, g, b)
  return string.format('#%02x%02x%02x', r, g, b)
end

---@param color1 string: First hex color (e.g., '#ff0000')
---@param color2 string: Second hex color (e.g., '#0000ff')
---@param proportion1 number: A number between 0 and 1 representing the mix proportion for color1
---@param proportion2 number: A number between 0 and 1 representing the mix proportion for color2
---@return string: A hex representing the mixed colors
function M.mix_colors(color1, color2, proportion1, proportion2)
  -- Ensure proportions are between 0 and 1
  local p1 = math.max(0, math.min(1, proportion1))
  local p2 = math.max(0, math.min(1, proportion2))

  local r1, g1, b1 = hex_to_rgb(color1)
  local r2, g2, b2 = hex_to_rgb(color2)

  local r = math.floor((r1 * p1) + (r2 * p2) + 0.5)
  local g = math.floor((g1 * p1) + (g2 * p2) + 0.5)
  local b = math.floor((b1 * p1) + (b2 * p2) + 0.5)

  -- Ensure values remain within the valid RGB range (0-255)
  r = math.max(0, math.min(255, r))
  g = math.max(0, math.min(255, g))
  b = math.max(0, math.min(255, b))

  return rgb_to_hex(r, g, b)
end

return M
