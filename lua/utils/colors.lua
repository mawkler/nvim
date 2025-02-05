local M = {}

---@param decimal number
---@return string
local function hex_from_decimal(decimal)
  return string.format('#%x', decimal)
end

--- Gets the foreground or background color value of a highlight group. Returns
--- white if - the group doesn't exist.
--- @param group_name string
--- @param part 'fg' | 'bg'
--- @return string
function M.get_highlight(group_name, part)
  part = part or 'fg'
  local hl = vim.api.nvim_get_hl(0, { name = group_name, link = false })

  if vim.tbl_isempty(hl) or not hl[part] then
    local message = string.format(
      "Highlight group %s doesn't exist or has no %s part",
      group_name,
      part
    )
    vim.notify(message, vim.log.levels.WARN)
    return '#ffffff'
  end
  return hex_from_decimal(hl[part])
end

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

--- Darkens `color` by `amount`
---@param color string: Base color to darken
---@param amount number: Number between 0 and 1 representing the amount to darken
---@return string: A hex representing the new color
function M.darken(color, amount)
  local background = M.get_highlight('Normal', 'bg')
  return M.mix_colors(color, background, 1 - amount, 0.3)
end

--- Brightens `color` by `amount`
---@param color string: Base color to brighten
---@param amount number: Number between 0 and 1 representing the amount to brighten
---@return string: A hex representing the new color
function M.brighten(color, amount)
  local background = M.get_highlight('Normal', 'fg')
  return M.mix_colors(color, background, amount, 0.3)
end

return M
