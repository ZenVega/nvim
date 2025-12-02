return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    -- Your Neo-tree options here
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    
    window = {
      position = "left",
      width = 30,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
          ["<cr>"] = function(state)
            local node = state.tree:get_node()
            if require("neo-tree.utils").is_expandable(node) then
              state.commands["toggle_node"](state)
            else
              -- Check if there are other windows besides Neo-tree
              local wins = vim.api.nvim_list_wins()
              local has_other_window = false
              for _, win in ipairs(wins) do
                local buf = vim.api.nvim_win_get_buf(win)
                local ft = vim.bo[buf].filetype
                if ft ~= "neo-tree" then
                  has_other_window = true
                  break
                end
              end
              
              if has_other_window then
                state.commands["open_with_window_picker"](state)
              else
                state.commands["open"](state)
              end
            end
          end,
        },
    },
    
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
  },
}
