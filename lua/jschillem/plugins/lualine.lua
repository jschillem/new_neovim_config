return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status")

    lualine.setup({
    options = {
      theme = "kanagawa",
      color = {
        gui = "bold",
      },
      section_separators = '',
      component_separators = '',
    },
    sections = {
      lualine_x = {
        {
          lazy_status.updates,
          cond = lazy_status.has_updates,
          color = { fg = "#DCA561" },
        },
        { "encoding" },
        { "fileformat" },
        { "filetype" },
      },
    },
  })
  end
}
