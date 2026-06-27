local function tree_width()
  return math.min(34, math.max(26, math.floor(vim.o.columns * 0.18)))
end

local function max_tree_width()
  return math.min(46, math.max(34, math.floor(vim.o.columns * 0.28)))
end

local function clamp_tree_width(width)
  return math.min(max_tree_width(), math.max(tree_width(), width))
end

local function buffer_width(buf)
  local width = 0

  for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    width = math.max(width, vim.fn.strdisplaywidth(line))
  end

  return width
end

local function resize_tree_to_width(win, width)
  width = clamp_tree_width(width)

  if vim.api.nvim_win_get_width(win) ~= width then
    vim.api.nvim_win_set_width(win, width)
  end
end

local function resize_tree()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_is_valid(win) then
      local buf = vim.api.nvim_win_get_buf(win)
      local config = vim.api.nvim_win_get_config(win)

      if vim.bo[buf].filetype == "neo-tree" and config.relative == "" then
        resize_tree_to_width(win, buffer_width(buf) + 2)
      end
    end
  end
end

local function resize_tree_after_render(state)
  if state.current_position == "float" or not vim.api.nvim_win_is_valid(state.winid) then
    return
  end

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(state.winid) then
      local buf = vim.api.nvim_win_get_buf(state.winid)

      resize_tree_to_width(state.winid, buffer_width(buf) + 2)
    end
  end)
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    keys = {},

    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        once = true,
        callback = function()
          if vim.fn.argc() == 0 then
            vim.bo.buflisted = false
          end

          vim.schedule(function()
            pcall(vim.cmd, "Neotree show filesystem left")
            resize_tree()
          end)
        end,
      })

      vim.api.nvim_create_autocmd({ "VimResized", "WinResized" }, {
        callback = function()
          vim.schedule(resize_tree)
        end,
      })
    end,

    opts = {
      close_if_last_window = false,

      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function()
            vim.schedule(resize_tree)
          end,
        },
        {
          event = "after_render",
          handler = resize_tree_after_render,
        },
      },

      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = "open_default",
      },

      default_component_configs = {
        file_size = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
      },

      window = {
        position = "left",
        width = tree_width,
      },
    },
  },
}
